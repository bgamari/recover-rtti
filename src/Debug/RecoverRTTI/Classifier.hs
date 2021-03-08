{-# LANGUAGE GADTs               #-}
{-# LANGUAGE KindSignatures      #-}

module Debug.RecoverRTTI.Classifier (
    Classifier(..)
  , MaybeEmpty(..)  
  , Classifiers(..)
  , Classified(..)
  ) where

import Data.Int
import Data.Kind
import Data.SOP
import Data.Void
import Data.Word

import qualified Data.ByteString       as BS.Strict
import qualified Data.ByteString.Lazy  as BS.Lazy
import qualified Data.ByteString.Short as BS.Short
import qualified Data.Text             as Text.Strict
import qualified Data.Text.Lazy        as Text.Lazy

import Debug.RecoverRTTI.Constr
import Debug.RecoverRTTI.UserDefined
import Debug.RecoverRTTI.Wrappers

{-------------------------------------------------------------------------------
  Classifier
-------------------------------------------------------------------------------}

-- | A value along with its classifier
data Classified a = Classified (Classifier a) a

-- | Classifier
--
-- Given a value of some unknown type @a@, a @Classifier a@ will tell you what
-- the type of @a@ is. This is similar to a @TypeRep@, but since we recover
-- this information from the heap, we have less accurate type information than
-- @TypeRep@ does.
data Classifier (a :: Type) :: Type where
  -- Primitive types

  C_Bool     :: Classifier Bool
  C_Char     :: Classifier Char
  C_Double   :: Classifier Double
  C_Float    :: Classifier Float
  C_Int      :: Classifier Int
  C_Int16    :: Classifier Int16
  C_Int8     :: Classifier Int8
  C_Int32    :: Classifier Int32
  C_Int64    :: Classifier Int64
  C_Ordering :: Classifier Ordering
  C_Unit     :: Classifier ()
  C_Word     :: Classifier Word
  C_Word8    :: Classifier Word8
  C_Word16   :: Classifier Word16
  C_Word32   :: Classifier Word32
  C_Word64   :: Classifier Word64

  -- String types
  --
  -- We list @String@ separately, so that we show them properly (rather than
  -- as a list of characters). Of course, empty strings will be inferred as
  -- empty lists instead.

  C_String      :: Classifier String
  C_BS_Strict   :: Classifier BS.Strict.ByteString
  C_BS_Lazy     :: Classifier BS.Lazy.ByteString
  C_BS_Short    :: Classifier BS.Short.ShortByteString
  C_Text_Strict :: Classifier Text.Strict.Text
  C_Text_Lazy   :: Classifier Text.Lazy.Text

  -- Compound

  C_List :: MaybeEmpty Classified a -> Classifier [a]

  -- Reference cells

  C_STRef :: Classifier SomeSTRef
  C_TVar  :: Classifier SomeTVar
  C_MVar  :: Classifier SomeMVar

  -- Functions

  C_Fun :: Classifier SomeFun

  -- User-defined

  C_Custom :: Sing c -> Classifier (UserDefined c)

  -- Classification failed

  C_Unknown :: Classifier Unknown

data MaybeEmpty f a where
  Empty    :: MaybeEmpty f Void
  NonEmpty :: f a -> MaybeEmpty f a

newtype Classifiers xs = Classifiers (NP Classifier xs)