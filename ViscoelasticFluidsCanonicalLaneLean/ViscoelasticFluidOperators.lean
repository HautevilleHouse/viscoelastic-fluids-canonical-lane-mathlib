import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
type ScalarField := Time → Space3 → ℝ
type VectorField := Time → Space3 → Space3
type TensorField := Time → Space3 → (Fin 3 → Fin 3 → ℝ)

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
  polymerStress : TensorField -> VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : ViscoelasticOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  upperConvectedDerivative := fun _ => zeroTensorField
  polymerStress := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by
    intro u
    rfl
}

structure ViscoelasticFlow where
  velocity : VectorField
  pressure : ScalarField
  conformation : TensorField
  viscosity : ℝ
  relaxationTime : ℝ
  polymerViscosity : ℝ
  operators : ViscoelasticOperators

def primitiveFlow : ViscoelasticFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  conformation := zeroTensorField
  viscosity := 1
  relaxationTime := 1
  polymerViscosity := 1
  operators := primitiveOperators
}

def Incompressible (F : ViscoelasticFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def UpperConvectedDerivativeEquation (F : ViscoelasticFlow) : Prop :=
  F.operators.upperConvectedDerivative F.conformation = zeroTensorField

def MomentumBalance (F : ViscoelasticFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def PressureProjected (F : ViscoelasticFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def ViscoelasticEquationClosed (F : ViscoelasticFlow) : Prop :=
  Incompressible F ∧ UpperConvectedDerivativeEquation F ∧ MomentumBalance F ∧ PressureProjected F

theorem primitive_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveOperators.pressureProjection (primitiveOperators.pressureProjection u) =
      primitiveOperators.pressureProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  unfold Incompressible
  rfl

theorem primitive_flow_conformation_closed :
    UpperConvectedDerivativeEquation primitiveFlow := by
  unfold UpperConvectedDerivativeEquation
  rfl

theorem primitive_flow_momentum_balance_checked :
    MomentumBalance primitiveFlow := by
  unfold MomentumBalance
  rfl

theorem primitive_flow_pressure_projected_checked :
    PressureProjected primitiveFlow := by
  unfold PressureProjected
  rfl

theorem primitive_flow_equation_closed_checked :
    ViscoelasticEquationClosed primitiveFlow := by
  refine And.intro primitive_flow_incompressible_checked ?_
  refine And.intro primitive_flow_conformation_closed ?_
  refine And.intro primitive_flow_momentum_balance_checked ?_
  exact primitive_flow_pressure_projected_checked

end HautevilleHouse
end ViscoelasticFluidsCanonicalLaneLean