#
# Tests elemental PPS running on multiple block
#
[Mesh]
  type = StripeMesh
  dim = 2
  xmin = 0
  xmax = 1
  ymin = 0
  ymax = 1
  nx = 3
  ny = 3
  elem_type = QUAD4
  stripes = 3
  # StripeMesh currently only works correctly with SerialMesh.
  distribution = serial
[]

[Functions]
  [./forcing_fn]
    type = ParsedFunction
    value = x
  [../]
[]

[Variables]
  [./u]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[Kernels]
  [./uv]
    type = Reaction
    variable = u
  [../]

  [./fv]
    type = UserForcingFunction
    variable = u
    function = forcing_fn
  [../]
[]

[Postprocessors]
  [./avg_1_2]
    type = ElementAverageValue
    variable = u
    block = '0 1'
  [../]
[]

[Executioner]
  type = Steady
[]

[Outputs]
  print_perf_log = true
  [./out]
    type = Exodus
    elemental_as_nodal = true
  [../]
[]
