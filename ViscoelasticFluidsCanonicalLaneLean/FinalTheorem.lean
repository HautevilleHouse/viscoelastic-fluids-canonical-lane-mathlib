import canonicalLaneMathlib.AdmissibleClass
import ViscoelasticFluidsCanonicalLaneLean.BridgeLemmas
import ViscoelasticFluidsCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

def ConstrainedViscoelasticClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_viscoelastic_endgame (A : AdmissibleClass) :
    ConstrainedViscoelasticClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse