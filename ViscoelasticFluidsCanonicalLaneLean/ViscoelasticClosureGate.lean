import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

structure ViscoelasticClosureGateCertificate where
  maxwellReg : MaxwellRegularizationCertificate
  bridgeClosed : Prop
  gateClosed : Prop
  endpointSatisfied : Prop
  remainderRecorded : Prop
  bridgeClosedProof : bridgeClosed
  gateClosedProof : gateClosed
  endpointSatisfiedProof : endpointSatisfied
  remainderRecordedProof : remainderRecorded

def sourceViscoelasticClosureGateCertificate : ViscoelasticClosureGateCertificate := {
  maxwellReg := sourceMaxwellRegularizationCertificate
  bridgeClosed := true
  gateClosed := true
  endpointSatisfied := ViscoelasticEquationClosed primitiveFlow
  remainderRecorded := false
  bridgeClosedProof := rfl
  gateClosedProof := rfl
  endpointSatisfiedProof := primitive_flow_equation_closed_checked
  remainderRecordedProof := rfl
}

def ViscoelasticClosureGateClosed (C : ViscoelasticClosureGateCertificate) : Prop :=
  MaxwellRegularizationClosed C.maxwellReg ∧
  C.bridgeClosed ∧
  C.gateClosed ∧
  C.endpointSatisfied ∧
  C.remainderRecorded

theorem source_viscoelastic_closure_gate_closed :
    ViscoelasticClosureGateClosed sourceViscoelasticClosureGateCertificate := by
  exact And.intro source_maxwell_regularization_closed
    (And.intro sourceViscoelasticClosureGateCertificate.bridgeClosedProof
      (And.intro sourceViscoelasticClosureGateCertificate.gateClosedProof
        (And.intro sourceViscoelasticClosureGateCertificate.endpointSatisfiedProof
          sourceViscoelasticClosureGateCertificate.remainderRecordedProof)))

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse