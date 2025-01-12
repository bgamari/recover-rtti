{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE EmptyCase           #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE FlexibleInstances   #-}
{-# LANGUAGE GADTs               #-}
{-# LANGUAGE KindSignatures      #-}
{-# LANGUAGE LambdaCase          #-}
{-# LANGUAGE RankNTypes          #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications    #-}

{-# OPTIONS_GHC -Wno-overlapping-patterns -Wno-incomplete-patterns -Wno-incomplete-uni-patterns -fno-opt-coercion #-}

-- | Valid tuple size
module Debug.RecoverRTTI.Tuple.Size (
    ValidSize(..)
  , TooBig(..)
  , smallerIsValid
  , IsValidSize(..)
  , liftValidSize
  , toValidSize
  ) where

import Data.Proxy
import Data.SOP.Dict

import Debug.RecoverRTTI.TypeLevel
import Debug.RecoverRTTI.Util

{-------------------------------------------------------------------------------
  Not generated
-------------------------------------------------------------------------------}

data ValidSize (n :: Nat) where
  ValidSize :: Sing n -> (forall r. TooBig n -> r) -> ValidSize n

smallerIsValid' :: forall n. ValidSize ('S n) -> ValidSize n
smallerIsValid' = \(ValidSize (SS n) tooBig) -> ValidSize n $ aux tooBig
  where
    aux :: (TooBig ('S n) -> r) -> TooBig n -> r
    aux tooBig TooBig = tooBig (TooBig :: TooBig ('S n))

-- | Smaller tuple sizes are always valid
--
-- This function is primarily useful when doing recursion on tuples: we may have
-- in scope evidence that @('S n)@ is a valid tuple size, and need to know that
-- @n@ is a valid tuple size in order to be able to make the recursive call.
smallerIsValid :: forall n r.
     IsValidSize ('S n)
  => Proxy ('S n)
  -> (IsValidSize n => r)
  -> r
smallerIsValid _ k =
    case liftValidSize (smallerIsValid' valid) of
      Dict -> k
  where
    valid :: ValidSize ('S n)
    valid = isValidSize

-- | Valid tuple sizes
--
-- GHC does not support tuples larger than 62 fields. We do allow for tuples of
-- zero size (which we interpret as unit @()@) and tuples of size one
-- (where @Tuple '[x] ~ x@).
class SingI n => IsValidSize n where
  isValidSize :: ValidSize n

{-------------------------------------------------------------------------------
  Generated
-------------------------------------------------------------------------------}

-- | Tuples with too many fields (more than 62)
data TooBig (n :: Nat) where
  TooBig :: TooBig ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S n)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

-- | Lift term-level evidence to type-level
liftValidSize :: forall n. ValidSize n -> Dict IsValidSize n
liftValidSize (ValidSize n notTooBig) = go n
  where
    go :: Sing n -> Dict IsValidSize n
    go SZ =
        Dict
    go (SS SZ) =
        Dict
    go (SS (SS SZ)) =
        Dict
    go (SS (SS (SS SZ))) =
        Dict
    go (SS (SS (SS (SS SZ)))) =
        Dict
    go (SS (SS (SS (SS (SS SZ))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS SZ)))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS SZ))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS SZ)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        Dict
    go (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS (SS _))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) =
        notTooBig (TooBig :: TooBig n)

instance IsValidSize 'Z where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S 'Z) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S 'Z)) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S 'Z))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S 'Z)))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S 'Z))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S 'Z)))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S 'Z))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

instance IsValidSize ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) where
  isValidSize = ValidSize sing $ \case

-- | Check the given size is a valid tuple size
toValidSize :: Int -> Maybe (Some ValidSize)
toValidSize = go
  where
    go :: Int -> Maybe (Some ValidSize)
    go 0 = Just . Some $
        isValidSize @'Z
    go 1 = Just . Some $
        isValidSize @('S 'Z)
    go 2 = Just . Some $
        isValidSize @('S ('S 'Z))
    go 3 = Just . Some $
        isValidSize @('S ('S ('S 'Z)))
    go 4 = Just . Some $
        isValidSize @('S ('S ('S ('S 'Z))))
    go 5 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S 'Z)))))
    go 6 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S 'Z))))))
    go 7 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S 'Z)))))))
    go 8 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))
    go 9 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))
    go 10 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))
    go 11 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))
    go 12 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))
    go 13 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))
    go 14 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))
    go 15 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))
    go 16 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))
    go 17 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))
    go 18 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))
    go 19 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))
    go 20 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))
    go 21 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))
    go 22 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))
    go 23 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))
    go 24 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))
    go 25 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))
    go 26 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))
    go 27 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))
    go 28 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))
    go 29 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))
    go 30 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))
    go 31 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))
    go 32 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))
    go 33 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))
    go 34 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))
    go 35 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))
    go 36 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))
    go 37 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))
    go 38 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))
    go 39 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))
    go 40 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))
    go 41 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))
    go 42 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))
    go 43 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))
    go 44 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))
    go 45 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))
    go 46 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))
    go 47 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))
    go 48 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))
    go 49 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))
    go 50 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))
    go 51 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))
    go 52 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 53 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 54 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 55 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 56 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 57 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 58 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 59 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 60 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 61 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go 62 = Just . Some $
        isValidSize @('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    go _ = Nothing
