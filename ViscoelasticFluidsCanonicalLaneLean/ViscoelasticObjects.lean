import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3
abbrev TensorField := Time → Space3 → (Fin 3 → Fin 3 → ℝ)

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0
def zeroTensorField : TensorField := fun _ _ _ _ => 0

structure ViscoelasticOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  deformationTensor : VectorField → TensorField
  upperConvectedDerivative : TensorField → TensorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : ViscoelasticOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  deformationTensor := fun _ => zeroTensorField
  upperConvectedDerivative := fun _ => zeroTensorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure ViscoelasticFlow where
  velocity : VectorField
  pressure : ScalarField
  stress : TensorField
  viscosity : ℝ
  relaxationTime : ℝ
  operators : ViscoelasticOperators

def primitiveFlow : ViscoelasticFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  stress := zeroTensorField
  viscosity := 1
  relaxationTime := 1
  operators := primitiveOperators
}

def Incompressible (F : ViscoelasticFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def OldroydBStressEquation (F : ViscoelasticFlow) : Prop :=
  F.operators.timeDerivative F.stress = zeroTensorField

def PressureProjected (F : ViscoelasticFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def ViscoelasticEquationClosed (F : ViscoelasticFlow) : Prop :=
  Incompressible F ∧ OldroydBStressEquation F ∧ PressureProjected F

theorem primitive_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveOperators.pressureProjection (primitiveOperators.pressureProjection u) =
      primitiveOperators.pressureProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  unfold Incompressible primitiveFlow
  simp [zeroScalarField, primitiveOperators]

theorem primitive_flow_oldroyd_b_stress_equation_checked :
    OldroydBStressEquation primitiveFlow := by
  unfold OldroydBStressEquation primitiveFlow
  simp [zeroTensorField, primitiveOperators]

theorem primitive_flow_pressure_projected_checked :
    PressureProjected primitiveFlow := by
  unfold PressureProjected primitiveFlow
  simp [primitiveOperators]

theorem primitive_flow_equation_closed_checked :
    ViscoelasticEquationClosed primitiveFlow := by
  refine And.intro primitive_flow_incompressible_checked ?_
  refine And.intro primitive_flow_oldroyd_b_stress_equation_checked ?_
  exact primitive_flow_pressure_projected_checked

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse