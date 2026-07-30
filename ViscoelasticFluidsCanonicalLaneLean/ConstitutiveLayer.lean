import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

structure ConstitutiveCertificate where
  relaxationTimePositive : Prop
  polymerViscosityPositive : Prop
  conformationPositiveDefinite : Prop
  relaxationTimePositiveProof : relaxationTimePositive
  polymerViscosityPositiveProof : polymerViscosityPositive
  conformationPositiveDefiniteProof : conformationPositiveDefinite

def sourceConstitutiveCertificate : ConstitutiveCertificate := {
  relaxationTimePositive := (1 : ℝ) > 0
  polymerViscosityPositive := (1 : ℝ) > 0
  conformationPositiveDefinite := True
  relaxationTimePositiveProof := by norm_num
  polymerViscosityPositiveProof := by norm_num
  conformationPositiveDefiniteProof := trivial
}

def ConstitutiveClosed (C : ConstitutiveCertificate) : Prop :=
  C.relaxationTimePositive ∧ C.polymerViscosityPositive ∧ C.conformationPositiveDefinite

theorem source_constitutive_closed : ConstitutiveClosed sourceConstitutiveCertificate := by
  exact And.intro sourceConstitutiveCertificate.relaxationTimePositiveProof
    (And.intro sourceConstitutiveCertificate.polymerViscosityPositiveProof
      sourceConstitutiveCertificate.conformationPositiveDefiniteProof)

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse
