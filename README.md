# GLSL Raymarching Fire Explosion

这是一个基于纯 GPU 渲染（GLSL 着色器）的火焰爆炸特效实验，运行于 Shadertoy 平台。

## 🎨 效果预览
![Fire Preview](preview.png)

## 🧠 核心技术
- **光线步进 (Raymarching)**：通过计算空间密度，实时渲染体积云与火焰效果。
- **FBM 分形噪声**：通过多层噪声叠加，模拟火焰燃烧时的不规则、流体状边缘。
- **自定义调色板**：在着色器中动态混合亮黄、橙、红、暗灰，产生逼真的燃烧色彩过渡。

## 🚀 如何运行
1. 打开 [Shadertoy](https://www.shadertoy.com/new)。
2. 将 `fire.glsl` 中的代码复制到代码编辑区。
3. 按下 `Alt + Enter` 即可实时预览。

## 💡 学习心得
这是我在搓完 C++ CPU 光线追踪器后，向 GPU 编程（Shader）迈出的第一步。相比于 CPU 的光线追踪，GPU 的 Raymarching 利用了显卡海量的并行算力，实现了实时高帧率（165 fps）的复杂体积渲染。