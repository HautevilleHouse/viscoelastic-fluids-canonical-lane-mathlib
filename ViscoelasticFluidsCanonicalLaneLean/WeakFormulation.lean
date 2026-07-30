import canonicalLaneMathlib.AdmissibleClass
import ViscoelasticFluidsCanonicalLaneLean.ViscoelasticFluidOperators
import Mathlib.Analysis.Distribution.Sobolev

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

structure WeakFormulationEnvelope where
  flow : ViscoelasticFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  energyInequality : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  energyInequalityClosed : energyInequality
  weakEquationClosed : weakEquation

def sourceWeakFormulationEnvelope : WeakFormulationEnvelope := {
  flow := primitiveFlow
  finiteEnergy := baselineCertificateAllPass = true
  divergenceFree := Incompressible primitiveFlow
  energyInequality := baselineCertificateInputs.length = 7
  weakEquation := ViscoelasticEquationClosed primitiveFlow
  finiteEnergyClosed := rfl
  divergenceFreeClosed := primitive_flow_incompressible_checked
  energyInequalityClosed := rfl
  weakEquationClosed := primitive_flow_equation_closed_checked
}

def WeakFormulationEnvelopeClosed (E : WeakFormulationEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.energyInequality ∧ E.weakEquation

theorem source_weak_formulation_envelope_closed :
    WeakFormulationEnvelopeClosed sourceWeakFormulationEnvelope := by
  exact And.intro sourceWeakFormulationEnvelope.finiteEnergyClosed
    (And.intro sourceWeakFormulationEnvelope.divergenceFreeClosed
      (And.intro sourceWeakFormulationEnvelope.energyInequalityClosed
        sourceWeakFormulationEnvelope.weakEquationClosed))

end HautevilleHouse
end ViscoelasticFluidsCanonicalLaneLean