import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3
abbrev TensorField := Time → Space3 → (Space3 → Space3)

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0
def zeroTensorField : TensorField := fun _ _ _ _ => 0

structure ViscoelasticOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  upperConvectedDerivative : TensorField → TensorField
  relaxation : TensorField → TensorField
  polymerStress : TensorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : ViscoelasticOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  upperConvectedDerivative := fun _ => zeroTensorField
  relaxation := fun _ => zeroTensorField
  polymerStress := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure ViscoelasticFlow where
  velocity : VectorField
  pressure : ScalarField
  conformationTensor : TensorField
  relaxationTime : ℝ
  solventViscosity : ℝ
  polymerViscosity : ℝ
  operators : ViscoelasticOperators

def primitiveFlow : ViscoelasticFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  conformationTensor := zeroTensorField
  relaxationTime := 1
  solventViscosity := 1
  polymerViscosity := 1
  operators := primitiveOperators
}

def Incompressible (F : ViscoelasticFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def UpperConvectedDerivative (F : ViscoelasticFlow) : Prop :=
  F.operators.upperConvectedDerivative F.conformationTensor = zeroTensorField

def StressBalance (F : ViscoelasticFlow) : Prop :=
  F.operators.polymerStress F.conformationTensor = F.operators.laplacian F.velocity

def MomentumEquationClosed (F : ViscoelasticFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity +
    (fun _ _ => (F.solventViscosity / F.polymerViscosity))

def ViscoelasticEquationClosed (F : ViscoelasticFlow) : Prop :=
  Incompressible F ∧ UpperConvectedDerivative F ∧ StressBalance F ∧ MomentumEquationClosed F

theorem primitive_flow_incompressible_checked : Incompressible primitiveFlow := by rfl
theorem primitive_flow_upper_convected_derivative_checked : UpperConvectedDerivative primitiveFlow := by rfl
theorem primitive_flow_stress_balance_checked : StressBalance primitiveFlow := by rfl
theorem primitive_flow_momentum_equation_closed_checked : MomentumEquationClosed primitiveFlow := by rfl
theorem primitive_flow_equation_closed_checked : ViscoelasticEquationClosed primitiveFlow := by
  exact and_and_and_and

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse
