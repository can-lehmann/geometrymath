# geometrymath

Linear algebra library for computer graphics and robotics applications.

## Vectors

The `Vec2`, `Vec3` and `Vec4` types are used to represent `float64` vectors.

```nim
let
  a = Vec2(x: 1, y: 2)
  b = Vec2(x: 3, y: 4)

echo 2.0 * a # (x: 2.0, y: 4.0)
echo a + b # (x: 4.0, y: 6.0)

echo dot(a, b) # 11.0
echo b.length() # 5.0
echo b.normalize() # (x: 0.6, y: 0.8)

echo a[AxisX] # 1.0
```

The `Index2`, `Index3` and `Index4` are vectors of type `int`.

```nim
let
  a = Index2(x: 1, y: 2)
  b = Index2(x: 3, y: 4)

echo 2 * a # (x: 2, y: 4)
echo a + b # (x: 4, y: 6)
echo a.toVec2() # (x: 1.0, y: 2.0)
```

## Matrices

Matrices are represented using the `StaticMatrix[T; H, W: static[int]]` type.
The `Mat2`, `Mat3` and `Mat4` type aliases represent square matrices of type `float64`.

```nim
let
  a = Mat2.identity()
  b = Mat2.init([float64 1, 2, 3, 4])
  c = StaticMatrix[float64, 2, 3].init([float64 1, 2, 3, 4, 5, 6])

echo a # [1.0, 0.0; 0.0, 1.0]

echo b * c # [9.0, 12.0, 15.0; 19.0, 26.0, 33.0]
echo b.det() # -2.0
echo c.transpose() # [1.0, 4.0; 2.0, 5.0; 3.0, 6.0]

echo b[0, 1] # 2.0
echo c[0..1, 0..1] # [1.0, 2.0; 4.0, 5.0]

echo Mat3.rotateZ(Deg(90))
# [6.123233995736766e-17, -1.0,                  0.0;
#  1.0,                   6.123233995736766e-17, 0.0;
#  0.0,                   0.0,                   1.0]
```

## Bounding Boxes

```nim
let box = Box2(
  min: Vec2(x: 1, y: 2),
  max: Vec2(x: 3, y: 4)
)

echo box.center # (x: 2.0, y: 3.0)
echo box.size # (x: 2.0, y: 2.0)

echo box.xInter # (min: 1.0, max: 3.0)
echo box.yInter # (min: 2.0, max: 4.0)
```

A 1-dimensional bounding box is called an interval.

```nim
let inter = Inter(min: 1, max: 2)
echo inter.size # 1.0
echo inter.center # 1.5
```

## License

geometrymath is licensed under the MIT license.
See `LICENSE.txt` for more information.
