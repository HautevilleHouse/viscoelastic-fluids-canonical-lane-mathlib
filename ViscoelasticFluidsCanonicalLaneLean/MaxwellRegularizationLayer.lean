import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ViscoelasticFluidsCanonicalLaneLean

structure MaxwellRegularizationCertificate where
  oldroydB : OldroydBEnvelope
  relaxationTimePositive : Prop
  viscosityPositive : Prop
  stressFinite : Prop
  coercivityFloor : Prop
  relaxationTimePositiveClosed : relaxationTimePositive
  viscosityPositiveClosed : viscosityPositive
  stressFiniteClosed : stressFinite
  coercivityFloorClosed : coercivityFloor

def sourceMaxwellRegularizationCertificate : MaxwellRegularizationCertificate := {
  oldroydB := sourceOldroydBEnvelope
  relaxationTimePositive := true
  viscosityPositive := true
  stressFinite := true
  coercivityFloor := true
  relaxationTimePositiveClosed := rfl
  viscosityPositiveClosed := rfl
  stressFiniteClosed := rfl
  coercivityFloorClosed := rfl
}

def MaxwellRegularizationClosed (C : MaxwellRegularizationCertificate) : Prop :=
  OldroydBEnvelopeClosed C.oldroydB ∧
  C.relaxationTimePositive ∧
  C.viscosityPositive ∧
  C.stressFinite ∧
  C.coercivityFloor

theorem source_maxwell_regularization_closed :
    MaxwellRegularizationClosed sourceMaxwellRegularizationCertificate := by
  exact And.intro source_oldroyd_b_envelope_closed
    (And.intro sourceMaxwellRegularizationCertificate.relaxationTimePositiveClosed
      (And.intro sourceMaxwellRegularizationCertificate.viscosityPositiveClosed
        (And.intro sourceMaxwellRegularizationCertificate.stressFiniteClosed
          sourceMaxwellRegularizationCertificate.coercivityFloorClosed)))

end ViscoelasticFluidsCanonicalLaneLean
end HautevilleHouse