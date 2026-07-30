import canonicalLaneMathlib.AdmissibleClass
import ViscoelasticFluidsCanonicalLaneLean.RegularityEndpointLayer

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

structure ViscoelasticAnalyticCertificate where
  substrate : MathlibPDESubstrate
  operatorsClosed : Prop
  weakLayerClosed : Prop
  energyLayerClosed : Prop
  compactnessLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  operatorsClosedProof : operatorsClosed
  weakLayerClosedProof : weakLayerClosed
  energyLayerClosedProof : energyLayerClosed
  compactnessLayerClosedProof : compactnessLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceViscoelasticAnalyticCertificate : ViscoelasticAnalyticCertificate := {
  substrate := mathlibPDESubstrate
  operatorsClosed := ViscoelasticEquationClosed primitiveFlow
  weakLayerClosed := WeakFormulationEnvelopeClosed sourceWeakFormulationEnvelope
  energyLayerClosed := EnergyDissipationClosed sourceEnergyDissipationCertificate
  compactnessLayerClosed := RigidityCompactnessClosed sourceRigidityCompactnessCertificate
  endpointLayerClosed := RegularityEndpointClosed sourceRegularityEndpointCertificate
  canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable
  operatorsClosedProof := primitive_flow_equation_closed_checked
  weakLayerClosedProof := source_weak_formulation_envelope_closed
  energyLayerClosedProof := source_energy_dissipation_closed
  compactnessLayerClosedProof := source_rigidity_compactness_closed
  endpointLayerClosedProof := source_regularity_endpoint_closed
  canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
    (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
}

def ViscoelasticAnalyticCertificateClosed (C : ViscoelasticAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.weakLayerClosed ∧
  C.energyLayerClosed ∧
  C.compactnessLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_viscoelastic_analytic_certificate_closed :
    ViscoelasticAnalyticCertificateClosed sourceViscoelasticAnalyticCertificate := by
  exact And.intro sourceViscoelasticAnalyticCertificate.operatorsClosedProof
    (And.intro sourceViscoelasticAnalyticCertificate.weakLayerClosedProof
      (And.intro sourceViscoelasticAnalyticCertificate.energyLayerClosedProof
        (And.intro sourceViscoelasticAnalyticCertificate.compactnessLayerClosedProof
          (And.intro sourceViscoelasticAnalyticCertificate.endpointLayerClosedProof
            sourceViscoelasticAnalyticCertificate.canonicalCarriageImportedProof))))

end HautevilleHouse
end ViscoelasticFluidsCanonicalLaneLean