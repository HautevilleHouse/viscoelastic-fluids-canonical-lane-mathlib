import canonicalLaneMathlib.AdmissibleClass
import ViscoelasticFluidsCanonicalLaneLean.ViscoelasticAnalyticCertificate

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

def ViscoelasticAdmittedAnalyticClosure : Prop :=
  ViscoelasticAnalyticCertificateClosed sourceViscoelasticAnalyticCertificate ∧
  ConstrainedTheoremClosure analyticAdmissibleClass

def UnrestrictedClassicalViscoelasticBoundaryCarried : Prop :=
  formalizationCertificate.theoremBoundaryOpen = true ∧
  mathlibPDESubstrate.unrestrictedNavierStokesStackCarried = true

theorem viscoelastic_admitted_analytic_closure_checked :
    ViscoelasticAdmittedAnalyticClosure := by
  exact And.intro source_viscoelastic_analytic_certificate_closed
    (constrained_theorem_closure analyticAdmissibleClass)

theorem unrestricted_classical_viscoelastic_boundary_carried_checked :
    UnrestrictedClassicalViscoelasticBoundaryCarried := by
  exact And.intro rfl rfl

end HautevilleHouse
end ViscoelasticFluidsCanonicalLaneLean