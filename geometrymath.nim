# MIT License
# 
# Copyright (c) 2022 Can Joshua Lehmann
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import std/[math, hashes]

type
  Vector2*[T] = object
    x*: T
    y*: T
  
  Vec2* = Vector2[float64]
  Index2* = Vector2[int]
  
  Vector3*[T] = object
    x*: T
    y*: T
    z*: T
  
  Vec3* = Vector3[float64]
  Index3* = Vector3[int]
  
  Vector4*[T] = object
    x*: T
    y*: T
    z*: T
    w*: T
  
  Vec4* = Vector4[float64]
  Index4* = Vector4[int]

template vectorUnop(op) =
  proc op*[T](vec: Vector2[T]): Vector2[T] {.inline.} =
    result = Vector2[T](x: op(vec.x), y: op(vec.y))
  
  proc op*[T](vec: Vector3[T]): Vector3[T] {.inline.} =
    result = Vector3[T](x: op(vec.x), y: op(vec.y), z: op(vec.z))
  
  proc op*[T](vec: Vector4[T]): Vector4[T] {.inline.} =
    result = Vector4[T](x: op(vec.x), y: op(vec.y), z: op(vec.z), w: op(vec.w))

vectorUnop(`-`)
vectorUnop(`abs`)
vectorUnop(`floor`)
vectorUnop(`ceil`)
vectorUnop(`round`)

template vectorBinop(op) =
  proc op*[T](a, b: Vector2[T]): Vector2[T] {.inline.} =
    result = Vector2[T](x: op(a.x, b.x), y: op(a.y, b.y))
  
  proc op*[T](a, b: Vector3[T]): Vector3[T] {.inline.} =
    result = Vector3[T](x: op(a.x, b.x), y: op(a.y, b.y), z: op(a.z, b.z))
  
  proc op*[T](a, b: Vector4[T]): Vector4[T] {.inline.} =
    result = Vector4[T](x: op(a.x, b.x), y: op(a.y, b.y), z: op(a.z, b.z), z: op(a.w, b.w))

vectorBinop(`+`)
vectorBinop(`-`)
vectorBinop(`*`)
vectorBinop(`/`)
vectorBinop(`mod`)
vectorBinop(`min`)
vectorBinop(`max`)

template vectorBinopScalar(op) =
  proc op*[T](a: T, b: Vector2[T]): Vector2[T] {.inline.} =
    result = Vector2[T](x: op(a, b.x), y: op(a, b.y))
  
  proc op*[T](a: Vector2[T], b: T): Vector2[T] {.inline.} =
    result = Vector2[T](x: op(a.x, b), y: op(a.y, b))

  proc op*[T](a: T, b: Vector3[T]): Vector3[T] {.inline.} =
    result = Vector3[T](x: op(a, b.x), y: op(a, b.y), z: op(a, b.z))
  
  proc op*[T](a: Vector3[T], b: T): Vector3[T] {.inline.} =
    result = Vector3[T](x: op(a.x, b), y: op(a.y, b), z: op(a.z, b))
  
  proc op*[T](a: T, b: Vector4[T]): Vector4[T] {.inline.} =
    result = Vector4[T](x: op(a, b.x), y: op(a, b.y), z: op(a, b.z), w: op(a, b.w))
  
  proc op*[T](a: Vector4[T], b: T): Vector4[T] {.inline.} =
    result = Vector4[T](x: op(a.x, b), y: op(a.y, b), z: op(a.z, b), w: op(a.w, b))

vectorBinopScalar(`*`)
vectorBinopScalar(`/`)
vectorBinopScalar(`mod`)
vectorBinopScalar(min)
vectorBinopScalar(max)

template vectorBinopMut(op) =
  proc op*[T](a: var Vector2[T], b: Vector2[T]) {.inline.} =
    op(a.x, b.x)
    op(a.y, b.y)
  
  proc op*[T](a: var Vector3[T], b: Vector2[T]) {.inline.} =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)
  
  proc op*[T](a: var Vector4[T], b: Vector2[T]) {.inline.} =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)
    op(a.w, b.w)

vectorBinopMut(`+=`)
vectorBinopMut(`-=`)
vectorBinopMut(`*=`)
vectorBinopMut(`/=`)

template vectorBinopMutScalar(op) =
  proc op*[T](a: var Vector2[T], b: T) {.inline.} =
    op(a.x, b)
    op(a.y, b)
  
  proc op*[T](a: var Vector3[T], b: T) {.inline.} =
    op(a.x, b)
    op(a.y, b)
    op(a.z, b)
  
  proc op*[T](a: var Vector4[T], b: T) {.inline.} =
    op(a.x, b)
    op(a.y, b)
    op(a.z, b)
    op(a.w, b)

vectorBinopMutScalar(`*=`)
vectorBinopMutScalar(`/=`)

{.push inline.}
proc dot*[T](a, b: Vector2[T]): T =
  result = a.x * b.x + a.y * b.y

proc dot*[T](a, b: Vector3[T]): T =
  result = a.x * b.x + a.y * b.y + a.z * b.z

proc dot*[T](a, b: Vector4[T]): T =
  result = a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w

proc length*[T](vec: Vector2[T]): float64 =
  result = sqrt(float64(vec.x * vec.x + vec.y * vec.y))

proc length*[T](vec: Vector3[T]): float64 =
  result = sqrt(float64(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z))

proc length*[T](vec: Vector4[T]): float64 =
  result = sqrt(float64(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z + vec.w * vec.w))

proc normalize*[T](vec: Vector2[T]): Vector2[T] = vec / T(vec.length())
proc normalize*[T](vec: Vector3[T]): Vector3[T] = vec / T(vec.length())
proc normalize*[T](vec: Vector4[T]): Vector4[T] = vec / T(vec.length())

proc cross*[T](a, b: Vector3[T]): Vector3[T] =
  result = Vector3[T](
    x: a.y * b.z - a.z * b.y,
    y: a.z * b.x - a.x * b.z,
    z: a.x * b.y - a.y * b.x
  )

proc toVec2*(index: Index2): Vec2 =
  result = Vec2(x: float64(index.x), y: float64(index.y))

proc toIndex2*(vec: Vec2): Index2 =
  result = Index2(x: int(vec.x), y: int(vec.y))
{.pop.}

type Axis* = distinct int

const
  AxisX* = Axis(0)
  AxisY* = Axis(1)
  AxisZ* = Axis(2)
  AxisW* = Axis(3)

{.push inline.}
proc `[]`*[T](vec: Vector2[T], axis: Axis): T = [vec.x, vec.y][int(axis)]
proc `[]`*[T](vec: Vector3[T], axis: Axis): T = [vec.x, vec.y, vec.z][int(axis)]
proc `[]`*[T](vec: Vector4[T], axis: Axis): T = [vec.x, vec.y, vec.z, vec.w][int(axis)]

proc `[]`*[T](vec: var Vector2[T], axis: Axis): var T = [vec.x.addr, vec.y.addr][int(axis)][]
proc `[]`*[T](vec: var Vector3[T], axis: Axis): var T = [vec.x.addr, vec.y.addr, vec.z.addr][int(axis)][]
proc `[]`*[T](vec: var Vector4[T], axis: Axis): var T = [vec.x.addr, vec.y.addr, vec.z.addr, vec.w.addr][int(axis)][]

proc `[]=`*[T](vec: var Vector2[T], axis: Axis, value: T) = [vec.x.addr, vec.y.addr][int(axis)][] = value
proc `[]=`*[T](vec: var Vector3[T], axis: Axis, value: T) = [vec.x.addr, vec.y.addr, vec.z.addr][int(axis)][] = value
proc `[]=`*[T](vec: var Vector4[T], axis: Axis, value: T) = [vec.x.addr, vec.y.addr, vec.z.addr, vec.w.addr][int(axis)][] = value
{.pop.}

type
  BoundingBox*[T] = object
    min*: T
    max*: T
  
  BoundingBox2*[T] = BoundingBox[Vector2[T]]
  Inter* = BoundingBox[float64]
  Box2* = BoundingBox2[float64]
  
  BoundingBox3*[T] = BoundingBox[Vector3[T]]
  Box3* = BoundingBox3[float64]

proc size*[T](box: BoundingBox[T]): T {.inline.} = box.max - box.min
proc center*[T](box: BoundingBox[T]): T {.inline.} = (box.max + box.min) / 2

proc xInter*[T](box: BoundingBox2[T]): BoundingBox[T] =
  result = BoundingBox[T](min: box.min.x, max: box.max.x)

proc yInter*[T](box: BoundingBox2[T]): BoundingBox[T] =
  result = BoundingBox[T](min: box.min.y, max: box.max.y)

type
  StaticMatrix*[T; H, W: static[int]] = object
    data*: array[H * W, T]
  
  Matrix2*[T] = StaticMatrix[T, 2, 2]
  Mat2* = StaticMatrix[float64, 2, 2]
  
  Matrix3*[T] = StaticMatrix[T, 3, 3]
  Mat3* = StaticMatrix[float64, 3, 3]
  
  Matrix4*[T] = StaticMatrix[T, 4, 4]
  Mat4* = StaticMatrix[float64, 4, 4]

{.push inline.}
proc `[]`*[T, H, W](mat: StaticMatrix[T, H, W], y, x: int): T = mat.data[x + y * W]
proc `[]`*[T, H, W](mat: var StaticMatrix[T, H, W], y, x: int): var T = mat.data[x + y * W]
proc `[]=`*[T, H, W](mat: var StaticMatrix[T, H, W], y, x: int, value: T) = mat.data[x + y * W] = value
{.pop.}

proc `$`*[T, H, W](mat: StaticMatrix[T, H, W]): string =
  result.add('[')
  for y in 0..<H:
    if y != 0:
      result.add("; ")
    for x in 0..<W:
      if x != 0:
        result.add(", ")
      result.add($mat[y, x])
  result.add(']')

proc transpose*[T, H, W](matrix: StaticMatrix[T, W, H]): StaticMatrix[T, H, W] =
  for y in 0..<H:
    for x in 0..<W:
      result[y, x] = matrix[x, y]

proc `*`*[T, H, W, N](a: StaticMatrix[T, H, N],
                      b: StaticMatrix[T, N, W]): StaticMatrix[T, H, W] =
  for y in 0..<H:
    for it in 0..<N:
      for x in 0..<W:
        result[y, x] += a[y, it] * b[it, x]

proc `[]`*[T, H, W](mat: StaticMatrix[T, H, W],
                    ySlice: static[HSlice[int, int]],
                    xSlice: static[HSlice[int, int]]): auto =
  result = StaticMatrix[T, ySlice.b - ySlice.a + 1, xSlice.b - xSlice.a + 1]()
  for y in ySlice:
    for x in xSlice:
      result[y - ySlice.a, x - xSlice.a] = mat[y, x]

proc det*[T](mat: Matrix2[T]): T =
  result = mat[0, 0] * mat[1, 1] - mat[0, 1] * mat[1, 0]

proc det*[T](mat: Matrix3[T]): T =
  for x in 0..<3:
    var
      a = T(1)
      b = T(-1)
    for y in 0..<3:
      a *= mat[y, (x + y) mod 3]
      b *= mat[2 - y, (x + y) mod 3]
    result += a + b

proc invert*[T](mat: Matrix3[T]): Matrix3[T] =
  template wrap(x, y: int): int =
    var res = x mod y
    if res < 0:
      res += y
    res
  
  template at(y, x: int): T = mat[wrap(y, 3), wrap(x, 3)]
  
  let d = det(mat)
  for y in 0..<3:
    for x in 0..<3:
      let
        a = at(x + 1, y + 1) * at(x - 1, y - 1)
        b = at(x + 1, y - 1) * at(x - 1, y + 1)
      result[y, x] = (a - b) / d

proc identity*[T, N](_: typedesc[StaticMatrix[T, N, N]]): StaticMatrix[T, N, N] =
  for it in 0..<N:
    result[it, it] = T(1)

proc translate*[T](typ: typedesc[Matrix4[T]], offset: Vector3[T]): Matrix4[T] =
  result = typ.identity()
  result[0, 3] = offset.x
  result[1, 3] = offset.y
  result[2, 3] = offset.z

proc scale*[T](typ: typedesc[Matrix4[T]], factors: Vector3[T]): Matrix4[T] =
  result[0, 0] = factors.x
  result[1, 1] = factors.y
  result[2, 2] = factors.z
  result[3, 3] = T(1)

proc init*[T; H, W](_: typedesc[StaticMatrix[T, H, W]], data: array[H * W, T]): StaticMatrix[T, H, W] =
  result = StaticMatrix[T, H, W](data: data)

proc toMatrix*[T](vec: Vector2[T]): StaticMatrix[T, 2, 1] =
  result = StaticMatrix[T, 2, 1](data: [vec.x, vec.y])

proc toMatrix*[T](vec: Vector3[T]): StaticMatrix[T, 3, 1] =
  result = StaticMatrix[T, 3, 1](data: [vec.x, vec.y, vec.z])

proc toMatrix*[T](vec: Vector4[T]): StaticMatrix[T, 4, 1] =
  result = StaticMatrix[T, 4, 1](data: [vec.x, vec.y, vec.z, vec.w])

proc toVector3*[T](mat: StaticMatrix[T, 3, 1]): Vector3[T] =
  result = Vector3[T](x: mat.data[0], y: mat.data[1], z: mat.data[2])

template defineUnit(T, Base: untyped, sym: string) =
  type T* = distinct Base
  
  proc `+`*(a, b: T): T {.borrow.}
  proc `-`*(a, b: T): T {.borrow.}
  proc `-`*(x: T): T {.borrow.}
  proc `/`*(a, b: T): float64 {.borrow.}
  
  proc `*`*(a: float64, b: T): T {.borrow.}
  proc `*`*(a: T, b: float64): T {.borrow.}
  
  proc `/`*(a: T, b: float64): T {.borrow.}
  
  proc `==`*(a, b: T): bool {.borrow.}
  proc `<`*(a, b: T): bool {.borrow.}
  proc `<=`*(a, b: T): bool {.borrow.}
  
  proc `+=`*(a: var T, b: T) {.borrow.}
  proc `-=`*(a: var T, b: T) {.borrow.}
  
  proc min*(a, b: T): T {.borrow.}
  proc max*(a, b: T): T {.borrow.}
  
  proc hash*(a: T): Hash {.borrow.}
  
  proc `$`*(x: T): string =
    result = $float64(x) & sym

defineUnit(Deg, float64, "°")
defineUnit(Rad, float64, "rad")

converter toRad*(deg: Deg): Rad =
  result = Rad(float64(deg) / 180 * PI)

converter toDeg*(rad: Rad): Deg =
  result = Deg(float64(rad) / PI * 180)

proc sin*(rad: Rad): float64 = sin(float64(rad))
proc cos*(rad: Rad): float64 = cos(float64(rad))
proc tan*(rad: Rad): float64 = tan(float64(rad))

proc rotate*(_: typedesc[Mat2], angle: Rad): Mat2 =
  result = Mat2(data: [
    cos(angle), -sin(angle),
    sin(angle), cos(angle)
  ])

proc rotateX*(_: typedesc[Mat3], angle: Rad): Mat3 =
  result = Mat3(data: [
    float64 1, 0, 0,
    0, cos(angle), -sin(angle),
    0, sin(angle), cos(angle)
  ])

proc rotateY*(_: typedesc[Mat3], angle: Rad): Mat3 =
  result = Mat3(data: [
    cos(angle), 0, sin(angle),
    0, 1, 0,
    -sin(angle), 0, cos(angle)
  ])

proc rotateZ*(_: typedesc[Mat3], angle: Rad): Mat3 =
  result = Mat3(data: [
    cos(angle), -sin(angle), 0,
    sin(angle), cos(angle), 0,
    0, 0, 1
  ])

proc rotateX*(_: typedesc[Mat4], angle: Rad): Mat4 =
  result = Mat4(data: [
    float64 1, 0, 0, 0,
    0, cos(angle), -sin(angle), 0,
    0, sin(angle), cos(angle), 0,
    0, 0, 0, 1
  ])

proc rotateY*(_: typedesc[Mat4], angle: Rad): Mat4 =
  result = Mat4(data: [
    cos(angle), 0, sin(angle), 0,
    0, 1, 0, 0,
    -sin(angle), 0, cos(angle), 0,
    0, 0, 0, 1
  ])

proc rotateZ*(_: typedesc[Mat4], angle: Rad): Mat4 =
  result = Mat4(data: [
    cos(angle), -sin(angle), 0, 0,
    sin(angle), cos(angle), 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
  ])
