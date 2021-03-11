{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE KindSignatures        #-}
{-# LANGUAGE LambdaCase            #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE StandaloneDeriving    #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE UndecidableInstances  #-}

module Test.RecoverRTTI.ConcreteClassifier (
    -- * Concrete classifier
    ConcreteClassifier(..)
  , sameConcreteClassifier
  , ConcreteClassifiers(..)
  , classifierSize
    -- * Values
  , Value(..)
  ) where

import Data.Int
import Data.Kind
import Data.SOP
import Data.SOP.Dict
import Data.Type.Equality
import Data.Word

import qualified Data.ByteString       as BS.Strict
import qualified Data.ByteString.Lazy  as BS.Lazy
import qualified Data.ByteString.Short as BS.Short
import qualified Data.Text             as Text.Strict
import qualified Data.Text.Lazy        as Text.Lazy

import Debug.RecoverRTTI
import Debug.RecoverRTTI.Util
import Debug.RecoverRTTI.Util.TypeLevel

import Test.RecoverRTTI.UserDefined

{-------------------------------------------------------------------------------
  Concrete classifier

  The difference between the " concrete " classifier and the 'Classifier' from
  the main library is that the former has explicit cases for user-defined types,
  and the latter doesn't (merely classifying them as 'UserDefined').

  In "Test.RecoverRRTI.Staged" we show that we can do staged inference,
  using 'classify' repeatedly to recover /all/ (concrete) type information
  from the type information returned by 'classify' (/if/ we have full
  information about which user-defined types we're interested in).
-------------------------------------------------------------------------------}

-- | Like 'Classifier', but with no guess-work and concrete types
data ConcreteClassifier (a :: Type) :: Type where
    -- Primitive types

    CC_Bool     :: ConcreteClassifier Bool
    CC_Char     :: ConcreteClassifier Char
    CC_Double   :: ConcreteClassifier Double
    CC_Float    :: ConcreteClassifier Float
    CC_Int      :: ConcreteClassifier Int
    CC_Int8     :: ConcreteClassifier Int8
    CC_Int16    :: ConcreteClassifier Int16
    CC_Int32    :: ConcreteClassifier Int32
    CC_Int64    :: ConcreteClassifier Int64
    CC_Ordering :: ConcreteClassifier Ordering
    CC_Unit     :: ConcreteClassifier ()
    CC_Word     :: ConcreteClassifier Word
    CC_Word8    :: ConcreteClassifier Word8
    CC_Word16   :: ConcreteClassifier Word16
    CC_Word32   :: ConcreteClassifier Word32
    CC_Word64   :: ConcreteClassifier Word64

    -- Text types

    CC_String      :: ConcreteClassifier String
    CC_BS_Strict   :: ConcreteClassifier BS.Strict.ByteString
    CC_BS_Lazy     :: ConcreteClassifier BS.Lazy.ByteString
    CC_BS_Short    :: ConcreteClassifier BS.Short.ShortByteString
    CC_Text_Strict :: ConcreteClassifier Text.Strict.Text
    CC_Text_Lazy   :: ConcreteClassifier Text.Lazy.Text

    -- Compound

    CC_Maybe :: MaybeEmpty ConcreteClassifier a -> ConcreteClassifier (Maybe a)
    CC_List  :: MaybeEmpty ConcreteClassifier a -> ConcreteClassifier [a]

    CC_Tuple ::
         (SListI xs, IsValidSize (Length xs))
      => ConcreteClassifiers xs -> ConcreteClassifier (WrappedTuple xs)

    -- Functions

    CC_Fun :: ConcreteClassifier SomeFun

    -- Reference cells

    CC_STRef :: ConcreteClassifier SomeSTRef
    CC_TVar  :: ConcreteClassifier SomeTVar
    CC_MVar  :: ConcreteClassifier SomeMVar

    -- User-defined

    CC_User_NonRec :: MaybeEmpty ConcreteClassifier a -> ConcreteClassifier (NonRecursive a)
    CC_User_Rec    :: MaybeEmpty ConcreteClassifier a -> ConcreteClassifier (Recursive    a)

newtype ConcreteClassifiers xs = ConcreteClassifiers (NP ConcreteClassifier xs)

deriving instance Show (ConcreteClassifier a)
deriving instance Show (MaybeEmpty ConcreteClassifier a)

instance SListI xs => Show (ConcreteClassifiers xs) where
  show (ConcreteClassifiers xs) = go (hpure Dict)
    where
      go :: NP (Dict (Compose Show ConcreteClassifier)) xs -> String
      go dicts =
          case all_NP dicts of
            Dict -> "(" ++ show xs ++ ")"

{-------------------------------------------------------------------------------
  Size of the classifier

  Mostly used for sanity checking the generator
-------------------------------------------------------------------------------}

classifierSize :: ConcreteClassifier a -> Int
classifierSize = go
  where
    go :: ConcreteClassifier a -> Int

    -- Primitive types
    go CC_Bool     = 1
    go CC_Char     = 1
    go CC_Double   = 1
    go CC_Float    = 1
    go CC_Int      = 1
    go CC_Int8     = 1
    go CC_Int16    = 1
    go CC_Int32    = 1
    go CC_Int64    = 1
    go CC_Ordering = 1
    go CC_Unit     = 1
    go CC_Word     = 1
    go CC_Word8    = 1
    go CC_Word16   = 1
    go CC_Word32   = 1
    go CC_Word64   = 1

    -- Text types
    go CC_String      = 1
    go CC_BS_Strict   = 1
    go CC_BS_Lazy     = 1
    go CC_BS_Short    = 1
    go CC_Text_Strict = 1
    go CC_Text_Lazy   = 1

    -- Compound

    go (CC_Maybe c) = 1 + goMaybeEmpty c
    go (CC_List  c) = 1 + goMaybeEmpty c

    go (CC_Tuple (ConcreteClassifiers cs)) =
        1 + sum (hcollapse (hmap (K . go) cs))

    -- Functions
    go CC_Fun = 1

    -- Reference cells
    go CC_STRef = 1
    go CC_TVar  = 1
    go CC_MVar  = 1

    -- User-defined
    go (CC_User_NonRec c) = 1 + goMaybeEmpty c
    go (CC_User_Rec    c) = 1 + goMaybeEmpty c

    goMaybeEmpty :: MaybeEmpty ConcreteClassifier a -> Int
    goMaybeEmpty Empty        = 0
    goMaybeEmpty (NonEmpty c) = go c

{-------------------------------------------------------------------------------
  Values
-------------------------------------------------------------------------------}

-- | Like 'Classified', but using 'ConcreteClassifier'
--
-- For convenience, we also include some constraints here, even though they
-- are in fact derivable from the classifier
data Value a where
   Value :: (Show a, Eq a) => ConcreteClassifier a -> a -> Value a

deriving instance Show (Value a)
deriving instance Show (Some Value)

{-------------------------------------------------------------------------------
  Equality
-------------------------------------------------------------------------------}

-- | Check that two classifiers are the same
--
-- If they are the same, additionally return a proof that that means the
-- /types/ they classify must be equal (note that equality on the classifiers
-- is strictly stronger than equality on the types: for example, non-empty
-- and empty lists have different classifiers, but classify the same type).
sameConcreteClassifier ::
     ConcreteClassifier a
  -> ConcreteClassifier b
  -> Maybe (a :~: b)
sameConcreteClassifier = go
  where
    go :: ConcreteClassifier a -> ConcreteClassifier b -> Maybe (a :~: b)
    go CC_Bool     CC_Bool     = Just Refl
    go CC_Char     CC_Char     = Just Refl
    go CC_Double   CC_Double   = Just Refl
    go CC_Float    CC_Float    = Just Refl
    go CC_Int      CC_Int      = Just Refl
    go CC_Int8     CC_Int8     = Just Refl
    go CC_Int16    CC_Int16    = Just Refl
    go CC_Int32    CC_Int32    = Just Refl
    go CC_Int64    CC_Int64    = Just Refl
    go CC_Ordering CC_Ordering = Just Refl
    go CC_Unit     CC_Unit     = Just Refl
    go CC_Word     CC_Word     = Just Refl
    go CC_Word8    CC_Word8    = Just Refl
    go CC_Word16   CC_Word16   = Just Refl
    go CC_Word32   CC_Word32   = Just Refl
    go CC_Word64   CC_Word64   = Just Refl

    -- String types

    go CC_String      CC_String      = Just Refl
    go CC_BS_Strict   CC_BS_Strict   = Just Refl
    go CC_BS_Lazy     CC_BS_Lazy     = Just Refl
    go CC_BS_Short    CC_BS_Short    = Just Refl
    go CC_Text_Strict CC_Text_Strict = Just Refl
    go CC_Text_Lazy   CC_Text_Lazy   = Just Refl

    -- Compound

    go (CC_Maybe c) (CC_Maybe c') = goF c c'
    go (CC_List  c) (CC_List  c') = goF c c'

    go (CC_Tuple (ConcreteClassifiers cs))
       (CC_Tuple (ConcreteClassifiers cs')) = (\Refl -> Refl) <$> goList cs cs'

    -- Reference cells

    go CC_STRef CC_STRef = Just Refl
    go CC_TVar  CC_TVar  = Just Refl
    go CC_MVar  CC_MVar  = Just Refl

    -- Functions

    go CC_Fun CC_Fun = Just Refl

    -- User-defined

    go (CC_User_NonRec c) (CC_User_NonRec c') = goF c c'
    go (CC_User_Rec    c) (CC_User_Rec    c') = goF c c'

    -- Otherwise, not equal

    go _ _ = Nothing

    goF ::
         MaybeEmpty ConcreteClassifier a
      -> MaybeEmpty ConcreteClassifier b
      -> Maybe (f a :~: f b)
    goF Empty        Empty         = Just Refl
    goF (NonEmpty c) (NonEmpty c') = (\Refl -> Refl) <$> go c c'
    goF _            _             = Nothing

    goList ::
         NP ConcreteClassifier xs
      -> NP ConcreteClassifier ys
      -> Maybe (xs :~: ys)
    goList Nil       Nil       = Just Refl
    goList (x :* xs) (y :* ys) = (\Refl Refl -> Refl) <$> go x y <*> goList xs ys
    goList Nil       (_ :* _)  = Nothing
    goList (_ :* _)  Nil       = Nothing

    -- Make sure we get a warning if we add another constructor
    _checkAllCases :: ConcreteClassifier a -> ()
    _checkAllCases = \case
        -- Primitive types

        CC_Bool     -> ()
        CC_Char     -> ()
        CC_Double   -> ()
        CC_Float    -> ()
        CC_Int      -> ()
        CC_Int8     -> ()
        CC_Int16    -> ()
        CC_Int32    -> ()
        CC_Int64    -> ()
        CC_Ordering -> ()
        CC_Unit     -> ()
        CC_Word     -> ()
        CC_Word8    -> ()
        CC_Word16   -> ()
        CC_Word32   -> ()
        CC_Word64   -> ()

        -- String types

        CC_String      -> ()
        CC_BS_Strict   -> ()
        CC_BS_Lazy     -> ()
        CC_BS_Short    -> ()
        CC_Text_Strict -> ()
        CC_Text_Lazy   -> ()

        -- Compound

        CC_Maybe{} -> ()
        CC_List{}  -> ()
        CC_Tuple{} -> ()

        -- Reference cells

        CC_STRef -> ()
        CC_TVar  -> ()
        CC_MVar  -> ()

        -- Functions

        CC_Fun -> ()

        -- User-defined

        CC_User_NonRec{} -> ()
        CC_User_Rec{}    -> ()
