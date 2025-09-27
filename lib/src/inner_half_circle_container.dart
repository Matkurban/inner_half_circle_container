import 'package:flutter/material.dart';

import 'notch_edge.dart';

/// 只支持多个向内半圆缺口的容器组件。
/// 通过 [notches] 传入需要在四条边上挖去的半圆集合，每个由 [HalfCircleNotch] 描述：
///   - edge: 缺口所在边 (top / bottom / left / right)
///   - center: 沿该边方向的偏移（像素）
///   - radius: 半径
/// 支持圆角，通过 [borderRadius]。背景色在 [color] 或通过 [decoration] 指定。
/// 现在支持可选的 [width]、[height]，若不指定则依赖父级约束自适应。
///
/// 示例：
/// InwardHalfCircleContainer(
///   width: 320,
///   height: 160,
///   notches: const [
///     HalfCircleNotch(edge: NotchEdge.left, center: 60, radius: 14),
///     HalfCircleNotch(edge: NotchEdge.right, center: 60, radius: 14),
///     HalfCircleNotch(edge: NotchEdge.bottom, center: 180, radius: 26),
///   ],
///   borderRadius: BorderRadius.all(Radius.circular(20)),
///   color: Colors.white,
///   child: ...,
/// )
class InnerHalfCircleContainer extends StatelessWidget {
  const InnerHalfCircleContainer({
    super.key,
    required this.notches,
    this.color = Colors.white,
    this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.decoration,
    this.width,
    this.height,
  }) : assert(notches.length > 0, 'notches 不能为空');

  /// 多个缺口定义（不能为空）
  final List<HalfCircleNotch> notches;

  /// 背景颜色（若同时提供 decoration.backgroundColor 则优先生效装饰里的 color）
  final Color color;

  /// 内部子组件
  final Widget? child;

  /// 容器圆角
  final BorderRadius borderRadius;

  /// 额外装饰（如阴影、渐变等）
  final BoxDecoration? decoration;

  /// 固定宽度（可选）
  final double? width;

  /// 固定高度（可选）
  final double? height;

  @override
  Widget build(BuildContext context) {
    Widget content = DecoratedBox(
      decoration: (decoration ?? BoxDecoration(color: color)).copyWith(
        color: decoration?.color ?? color,
      ),
      child: child,
    );

    content = ClipPath(
      clipper: _MultiInwardHalfCircleClipper(notches: notches, borderRadius: borderRadius),
      child: content,
    );

    if (width != null || height != null) {
      content = SizedBox(width: width, height: height, child: content);
    }
    return content;
  }
}



/// 多个缺口的数据模型。
class HalfCircleNotch {
  const HalfCircleNotch({required this.edge, required this.center, required this.radius});
  final NotchEdge edge;
  final double center; // 圆心在该边方向的偏移
  final double radius; // 半径
  @override
  String toString() => 'HalfCircleNotch(edge: $edge, center: $center, radius: $radius)';
}

// 移除了 _InwardHalfCircleClipper，统一使用多缺口裁剪器。
class _MultiInwardHalfCircleClipper extends CustomClipper<Path> {
  _MultiInwardHalfCircleClipper({required this.notches, required this.borderRadius});
  final List<HalfCircleNotch> notches;
  final BorderRadius borderRadius;
  @override
  Path getClip(Size size) {
    final rectPath = Path()..addRRect(borderRadius.toRRect(Offset.zero & size));
    final notchPath = Path();
    for (final n in notches) {
      double safeCenter = n.center;
      if (n.edge == NotchEdge.top || n.edge == NotchEdge.bottom) {
        safeCenter = safeCenter.clamp(n.radius, size.width - n.radius);
      } else {
        safeCenter = safeCenter.clamp(n.radius, size.height - n.radius);
      }
      late Offset center;
      switch (n.edge) {
        case NotchEdge.top:
          center = Offset(safeCenter, 0);
          break;
        case NotchEdge.bottom:
          center = Offset(safeCenter, size.height);
          break;
        case NotchEdge.left:
          center = Offset(0, safeCenter);
          break;
        case NotchEdge.right:
          center = Offset(size.width, safeCenter);
          break;
      }
      notchPath.addOval(Rect.fromCircle(center: center, radius: n.radius));
    }
    return Path.combine(PathOperation.difference, rectPath, notchPath);
  }

  @override
  bool shouldReclip(covariant _MultiInwardHalfCircleClipper oldClipper) {
    if (oldClipper.borderRadius != borderRadius) return true;
    if (oldClipper.notches.length != notches.length) return true;
    for (int i = 0; i < notches.length; i++) {
      final a = notches[i];
      final b = oldClipper.notches[i];
      if (a.edge != b.edge || a.center != b.center || a.radius != b.radius) return true;
    }
    return false;
  }
}
