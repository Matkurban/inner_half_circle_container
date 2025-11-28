# Inner Half Circle Container / 内凹半圆容器

`InnerHalfCircleContainer` lets you punch multiple inward half-circle notches on any side of a rectangular widget so you can craft ticket stubs, perforated cards, or ergonomic grips without manual path math.
`InnerHalfCircleContainer` 可以在矩形组件的任意边缘挖出多个向内的半圆缺口，用来快速实现票券、撕口卡片或手柄等造型，无需手动计算路径。

<img src="doc/screenshot.png" alt="Inner Half Circle Container screenshot" width="600" />

## Installation / 安装

Add the package to your `pubspec.yaml` and run `flutter pub get`.
在 `pubspec.yaml` 中加入依赖并执行 `flutter pub get`。

```yaml
dependencies:
  inner_half_circle_container: ^1.0.0
```

Then import it wherever you build the widget tree.
在需要使用的文件中导入：

```dart
import 'package:inner_half_circle_container/inner_half_circle_container.dart';
```

## Quick Start / 快速上手

```dart
InnerHalfCircleContainer(
  width: 320,
  height: 160,
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(24)),
  notches: const [
    HalfCircleNotch(edge: NotchEdge.left, center: 60, radius: 16),
    HalfCircleNotch(edge: NotchEdge.right, center: 60, radius: 16),
    HalfCircleNotch(edge: NotchEdge.bottom, center: 200, radius: 26),
  ],
  child: const Center(child: Text('Ticket')),
);
```

## Parameters / 参数说明
- `notches` *(required)*: list of `HalfCircleNotch` describing edge, center offset, and radius.
  `notches`（必填）：`HalfCircleNotch` 集合，定义缺口所在的边、中心偏移与半径。
- `borderRadius`: `BorderRadius` applied before carving out notches.
  `borderRadius`：在挖缺口前先应用的圆角。
- `color`: fallback fill color when `decoration.color` is absent.
  `color`：当未提供 `decoration.color` 时的填充色。
- `decoration`: optional `BoxDecoration` to add gradients, shadows, etc.
  `decoration`：可选的 `BoxDecoration`，用于渐变、阴影等效果。
- `width` / `height`: optional fixed constraints if parent does not size the widget.
  `width` / `height`：可选固定尺寸，父级未约束时可直接指定。
- `child`: widget rendered inside the clipped shape.
  `child`：显示在裁剪形状内部的子组件。

## Example App / 示例应用
Run the bundled sample to preview three preset layouts.
运行内置示例，快速预览三种预设布局。

```bash
cd example
flutter run
```

## License / 许可
MIT © Matkurban
MIT 开源许可 © Matkurban
