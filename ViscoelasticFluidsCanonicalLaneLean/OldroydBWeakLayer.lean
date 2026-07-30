import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

structure OldroydBEnvelope where
  flow : ViscoelasticFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  stressConstitutive : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  stressConstitutiveClosed : stressConstitutive
  weakEquationClosed : weakEquation

def sourceOldroydBEnvelope : OldroydBEnvelope := {
  flow := primitiveFlow
  finiteEnergy := true
  divergenceFree := Incompressible primitiveFlow
  stressConstitutive := OldroydBStressEquation primitiveFlow
  weakEquation := ViscoelasticEquationClosed primitiveFlow
  finiteEnergyClosed := rfl
  divergenceFreeClosed := primitive_flow_incompressible_checked
  stressConstitutiveClosed := primitive_flow_oldroyd_b_stress_equation_checked
  weakEquationClosed := primitive_flow_equation_closed_checked
}

def OldroydBEnvelopeClosed (E : OldroydBEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.stressConstitutive ∧ E.weakEquation

theorem source_oldroyd_b_envelope_closed :
    OldroydBEnvelopeClosed sourceOldroydBEnvelope := by
  exact And.intro sourceOldroydBEnvelope.finiteEnergyClosed
    (And.intro sourceOldroydBEnvelope.divergenceFreeClosed
      (And.intro sourceOldroydBEnvelope.stressConstitutiveClosed
        sourceOldroydBEnvelope.weakEquationClosed))

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse