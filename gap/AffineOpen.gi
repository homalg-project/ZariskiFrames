# SPDX-License-Identifier: GPL-2.0-or-later
# ZariskiFrames: (Co)frames/Locales of Zariski closed/open subsets of affine, projective, or toric varieties
#
# Implementations
#

## fallback method
InstallMethod( BaseOfFibration,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframe and IsObjectInZariskiFrameOrCoframeOfAnAffineVariety ],
        
  function( A )
    
    return TerminalObject( ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( UnderlyingRing( A ) ) );
    
end );

##
InstallMethod( OpenSubsetOfSpec,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, R_elim, A, ZF, B;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := AsMorphismInCategoryOfRows( R_elim * UnderlyingMatrix( I ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZF := ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                PreMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsOpen, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                PreMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                IsOpen, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpec,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return OpenSubsetOfSpec( AsMorphismInCategoryOfRows( mat ) );
    
end );

##
InstallMethod( OpenSubsetOfSpecByReducedMorphism,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, R_elim, A, ZF, B;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := AsMorphismInCategoryOfRows( R_elim * UnderlyingMatrix( I ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZF := ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                ReducedMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsOpen, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                ReducedMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                IsOpen, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpecByReducedMorphism,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return OpenSubsetOfSpecByReducedMorphism( AsMorphismInCategoryOfRows( mat ) );
    
end );

##
InstallMethod( OpenSubsetOfSpecByListOfMorphismsOfRank1Range,
        "for a list",
        [ IsList ],

  function( L )
    local l, R, R_elim, A, ZF, B;
    
    l := L[1];
    
    L := Filtered( L, l -> not IsZero( l ) );
    
    if L = [ ] then
        L := [ l ];
    fi;
    
    L := DuplicateFreeList( L );
    
    R := UnderlyingRing( CapCategory( l ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        L := List( L, I -> AsMorphismInCategoryOfRows( R_elim * UnderlyingMatrix( I ) ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZF := ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                ListOfMorphismsOfRank1RangeOfUnderlyingCategory, L,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsOpen, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                ListOfMorphismsOfRank1RangeOfUnderlyingCategory, L,
                UnderlyingRing, R,
                IsOpen, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpecByStandardMorphism,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, R_elim, A, ZF, B;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := AsMorphismInCategoryOfRows( R_elim * UnderlyingMatrix( I ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZF := ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                StandardMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiFrameOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsOpen, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZF,
                StandardMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                IsOpen, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( OpenSubsetOfSpecByStandardMorphism,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return OpenSubsetOfSpecByStandardMorphism( AsMorphismInCategoryOfRows( mat ) );
    
end );

##
InstallMethod( OpenSubsetOfSpec,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return OpenSubsetOfSpec( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( OpenSubsetOfSpecByReducedMorphism,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return OpenSubsetOfSpecByReducedMorphism( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( OpenSubsetOfSpecByStandardMorphism,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return OpenSubsetOfSpecByStandardMorphism( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ZariskiFrameOfAffineSpectrumUsingCategoryOfRows,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local name, ZariskiFrame;
    
    R := PolynomialRingWithProductOrdering( R );
    
    name := "The frame of Zariski open subsets of the affine spectrum of ";
    
    name := Concatenation( name, RingName( R ) );
    
    ZariskiFrame := CreateCapCategory( name );
    
    SetFilterObj( ZariskiFrame, IsZariskiFrameOfAnAffineVariety );
    
    ZariskiFrame!.category_as_first_argument := true;
    
    SetUnderlyingRing( ZariskiFrame, R );
    
    if not IsBound( R!.CategoryOfRows ) then
        R!.CategoryOfRows := CategoryOfRows( R : overhead := false );
    fi;
    
    ZariskiFrame!.UnderlyingCategory := R!.CategoryOfRows;
    
    ZariskiFrame!.Constructor := OpenSubsetOfSpec;
    ZariskiFrame!.ConstructorByListOfMorphismsOfRank1Range := OpenSubsetOfSpecByListOfMorphismsOfRank1Range;
    ZariskiFrame!.ConstructorByReducedMorphism := OpenSubsetOfSpecByReducedMorphism;
    ZariskiFrame!.ConstructorByStandardMorphism := OpenSubsetOfSpecByStandardMorphism;
    
    AddObjectRepresentation( ZariskiFrame, IsObjectInZariskiFrameOfAnAffineVariety );
    
    AddMorphismRepresentation( ZariskiFrame, IsMorphismInZariskiFrameOfAnAffineVariety );
    
    ADD_COMMON_METHODS_FOR_HEYTING_ALGEBRAS( ZariskiFrame );
    
    ADD_COMMON_METHODS_FOR_FRAMES_AND_COFRAMES_DEFINED_USING_CategoryOfRows( ZariskiFrame );
    
    ##
    AddIsHomSetInhabited( ZariskiFrame,
      { cat, S, T } -> IsHomSetInhabitedForFramesUsingCategoryOfRows( S, T ) );
    
    ##
    if IsBound( homalgTable( R )!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ##
        AddIsEqualForObjectsIfIsHomSetInhabited( ZariskiFrame,
          { cat, A, B } -> IsEqualForObjectsIfIsHomSetInhabitedForFramesUsingCategoryOfRows( A, B ) );
        
    fi;
    
    ##
    AddIsEqualForObjects( ZariskiFrame,
      function( cat, A, B )
        
        if not DimensionOfComplement( A ) = DimensionOfComplement( B ) then
            return false;
        fi;
        
        return IsHomSetInhabited( A, B ) and IsEqualForObjectsIfIsHomSetInhabited( A, B );
        
    end );
    
    ##
    AddTerminalObject( ZariskiFrame,
      function( cat )
        local T;
        
        T := OpenSubsetOfSpecByStandardMorphism( HomalgIdentityMatrix( 1, R ) );
        
        SetIsTerminal( T, true );
        
        return T;
        
    end );
    
    ##
    AddInitialObject( ZariskiFrame,
      function( cat )
        local I;
        
        I := OpenSubsetOfSpecByStandardMorphism( HomalgZeroMatrix( 0, 1, R ) );
        
        SetIsInitial( I, true );
        
        return I;
        
    end );
    
    ##
    AddIsTerminal( ZariskiFrame,
      function( cat, A )
        local mor;
        
        mor := ListOfMorphismsOfRank1RangeOfUnderlyingCategory( A );
        
        return ForAll( mor, IsSplitEpimorphism );
        
    end );
    
    ##
    AddIsInitial( ZariskiFrame,
      function( cat, A )
        
        return IsZero( MorphismOfRank1RangeOfUnderlyingCategory( A ) );
        
    end );
    
    ##
    AddCoproduct( ZariskiFrame,
      function( cat, L )
        local l;
        
        ## triggers radical computations which we want to avoid by all means
        #L := MaximalObjects( L, IsHomSetInhabited );
        ## instead:
        
        l := L[1];
        
        ## testing the membership of 1 might be very expensive for some ideals in the sum
        if ForAny( L, a -> HasIsTerminal( a ) and IsTerminal( a ) ) then
            return TerminalObject( CapCategory( l ) );
        fi;
        
        L := Filtered( L, A -> not IsInitial( A ) );
        
        if L = [ ] then
            return InitialObject( CapCategory( l ) );
        elif Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, MorphismOfRank1RangeOfUnderlyingCategory );
        
        L := DuplicateFreeList( L );
        
        ## examples show that the GB computations of the entries of L
        ## (needed to check IsLiftable) might be immensely more expensive
        ## than the GB of the resulting UniversalMorphismFromDirectSum( L ),
        ## so never execute the next line:
        #L := MaximalObjects( L, IsLiftable );
        
        l := UniversalMorphismFromDirectSum( L );
        
        l := OpenSubsetOfSpec( l );
        
        SetIsInitial( l, false );
        
        return l;
        
    end );
    
    ##
    AddDirectProduct( ZariskiFrame,
      function( cat, L )
        local l;
        
        l := L[1];
        
        if ForAny( L, IsInitial ) then
            return InitialObject( CapCategory( l ) );
        fi;
        
        L := Filtered( L, A -> not IsTerminal( A ) );
        
        if L = [ ] then
            return TerminalObject( CapCategory( l ) );
        elif Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, ListOfMorphismsOfRank1RangeOfUnderlyingCategory );
        
        L := Concatenation( L );
        
        l := OpenSubsetOfSpecByListOfMorphismsOfRank1Range( L );
        
        SetIsTerminal( l, false );
        
        return l;
        
    end );
    
    ##
    AddExponentialOnObjects( ZariskiFrame,
      function( cat, A, B )
        local L;
        
        A := MorphismOfUnderlyingCategory( A );
        
        if IsZero( A ) then
            return TerminalObject( CapCategory( B ) );
        fi;
        
        B := MorphismOfUnderlyingCategory( B );
        
        A := UnderlyingMatrix( A );
        B := UnderlyingMatrix( B );
        
        L := List( [ 1 .. NrRows( A ) ], r -> SyzygiesGeneratorsOfRows( CertainRows( A, [ r ] ), B ) );
        
        L := List( L, OpenSubsetOfSpecByReducedMorphism );
        
        return DirectProduct( L );
        
    end );
    
    Finalize( ZariskiFrame );
    
    ZariskiFrame!.ZariskiCoframe := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    SetZariskiFrameOfAffineSpectrumUsingCategoryOfRows( R, ZariskiFrame );
    
    return ZariskiFrame;
    
end );

##
InstallMethod( IsClosedSubobject,
        "for an object in a Zariski frame of an affine variety",
        [ IsObjectInZariskiFrameOfAnAffineVariety ],

  function( A )
    
    return IsClosed( AsDifferenceOfClosed( A ) );
    
end );

##
InstallMethod( DimensionOfComplement,
        "for an object in a Zariski frame of an affine variety",
        [ IsObjectInZariskiFrameOfAnAffineVariety ],
        
  function( A )
    
    A := ListOfMorphismsOfRank1RangeOfUnderlyingCategory( A );
    
    A := List( A, UnderlyingMatrix );
    
    return Maximum( List( A, AffineDimension ) );
    
end );

##
InstallMethod( DegreeOfComplement,
        "for an object in a Zariski frame of an affine variety",
        [ IsObjectInZariskiFrameOfAnAffineVariety ],

  function( A )
    
    return AffineDegree( UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) ) );
    
end );
