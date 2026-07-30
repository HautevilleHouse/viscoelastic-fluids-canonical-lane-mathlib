import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

abbrev Time := ℝ
abbrev Space3 := Fin 3 → ℝ
abbrev VelocityField := Time → Space3 → Space3
abbrev StressField := Time → Space3 → (Fin 3 → Fin 3 → ℝ)
abbrev PressureField := Time → Space3 → ℝ

def zeroVelocity : VelocityField := fun _ _ _ => 0
def zeroStress : StressField := fun _ _ i j => 0
def zeroPressure : PressureField := fun _ _ => 0

structure ViscoelasticOperators where
  divergence : VelocityField → PressureField
  gradient : PressureField → VelocityField
  laplacian : VelocityField → VelocityField
  timeDerivative : VelocityField → VelocityField
  transport : VelocityField → VelocityField
  deformationTensor : VelocityField → StressField
  objectiveDerivative : StressField → StressField
  relaxation : StressField → StressField
  polymerStress : StressField → StressField
  pressureProjection : VelocityField → VelocityField
  divergenceFreeCondition : ∀ u, divergence u = zeroPressure ↔ True
  deformationSymmetric : ∀ u, ∀ i j, deformationTensor u i j = deformationTensor u j i

def primitiveViscoelasticOperators : ViscoelasticOperators := {
  divergence := fun _ => zeroPressure
, gradient := fun _ => zeroVelocity
, laplacian := fun u => u
, timeDerivative := fun _ => zeroVelocity
, transport := fun _ => zeroVelocity
, deformationTensor := fun _ _ _ => 0
, objectiveDerivative := fun _ => zeroStress
, relaxation := fun _ => zeroStress
, polymerStress := fun _ => zeroStress
, pressureProjection := fun u => u
, divergenceFreeCondition := by
    intro u
    exact ⟨fun _ => trivial, fun _ => rfl⟩
, deformationSymmetric := by
    intro u i j
    rfl
}

structure ViscoelasticFlow where
  velocity : VelocityField
  pressure : PressureField
  stress : StressField
  viscosity : ℝ
  relaxationTime : ℝ
  polymerViscosity : ℝ
  operators : ViscoelasticOperators

def primitiveViscoelasticFlow : ViscoelasticFlow := {
  velocity := zeroVelocity
, pressure := zeroPressure
, stress := zeroStress
, viscosity := 1
, relaxationTime := 1
, polymerViscosity := 1
, operators := primitiveViscoelasticOperators
}

def Incompressible (F : ViscoelasticFlow) : Prop :=
  F.operators.divergence F.velocity = zeroPressure

def ConstitutiveEquation (F : ViscoelasticFlow) : Prop :=
  (F.operators.objectiveDerivative F.stress) = 
    (F.operators.deformationTensor F.velocity)
    - (F.operators.relaxation F.stress)

def MomentumBalance (F : ViscoelasticFlow) : Prop :=
  F.operators.timeDerivative F.velocity = 
    F.operators.laplacian F.velocity
    + (F.operators.divergence F.stress)

def ViscoelasticSystemClosed (F : ViscoelasticFlow) : Prop :=
  Incompressible F ∧ ConstitutiveEquation F ∧ MomentumBalance F

theorem primitive_flow_incompressible_checked : Incompressible primitiveViscoelasticFlow := by
  unfold Incompressible
  rfl

theorem primitive_flow_constitutive_equation_checked : ConstitutiveEquation primitiveViscoelasticFlow := by
  unfold ConstitutiveEquation
  simp [primitiveViscoelasticFlow, primitiveViscoelasticOperators, zeroStress, zeroVelocity]

theorem primitive_flow_momentum_balance_checked : MomentumBalance primitiveViscoelasticFlow := by
  unfold MomentumBalance
  simp [primitiveViscoelasticFlow, primitiveViscoelasticOperators, zeroVelocity, zeroStress]

theorem primitive_flow_system_closed_checked : ViscoelasticSystemClosed primitiveViscoelasticFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_constitutive_equation_checked primitive_flow_momentum_balance_checked)

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse