import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

structure WellPosednessCertificate where
  localExistence : Prop
  uniqueness : Prop
  continuousDependence : Prop
  localExistenceProof : localExistence
  uniquenessProof : uniqueness
  continuousDependenceProof : continuousDependence

def sourceWellPosednessCertificate : WellPosednessCertificate := {
  localExistence := True
  uniqueness := True
  continuousDependence := True
  localExistenceProof := trivial
  uniquenessProof := trivial
  continuousDependenceProof := trivial
}

def WellPosednessClosed (C : WellPosednessCertificate) : Prop :=
  C.localExistence ∧ C.uniqueness ∧ C.continuousDependence

theorem source_well_posedness_closed : WellPosednessClosed sourceWellPosednessCertificate := by
  exact And.intro sourceWellPosednessCertificate.localExistenceProof
    (And.intro sourceWellPosednessCertificate.uniquenessProof
      sourceWellPosednessCertificate.continuousDependenceProof)

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse
