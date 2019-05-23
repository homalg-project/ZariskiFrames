#
# ZariskiFrames: The coframe of Zariski closed subsets in an affine variety
#
# Implementations
#

## fallback method
InstallMethod( BaseOfFibration,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframe and IsObjectInZariskiFrameOrCoframeOfAnAffineVariety ],
        
  function( A )
    
    return TerminalObject( ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( UnderlyingRing( A ) ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpec,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, R_elim, A, ZC, B;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := AsCategoryOfRowsMorphism( R_elim * UnderlyingMatrix( I ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                PreMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsClosedSubobject, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                PreMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                IsClosedSubobject, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpec,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return ClosedSubsetOfSpec( AsCategoryOfRowsMorphism( mat ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpec,
        "for a homalg ring element",
        [ IsHomalgRingElement ],

  function( r )
    
    return ClosedSubsetOfSpec( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, R_elim, A, ZC, B;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := AsCategoryOfRowsMorphism( R_elim * UnderlyingMatrix( I ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                ReducedMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsClosedSubobject, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                ReducedMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                IsClosedSubobject, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return ClosedSubsetOfSpecByReducedMorphism( AsCategoryOfRowsMorphism( mat ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a homalg ring element",
        [ IsHomalgRingElement ],

  function( r )
    
    return ClosedSubsetOfSpecByReducedMorphism( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpecByListOfMorphismsOfRank1Range,
        "for a list",
        [ IsList ],

  function( L )
    local l, R, R_elim, A, ZC, B;
    
    List( L, IsZero );
    
    l := L[1];
    
    L := Filtered( L, l -> not ( IsEndomorphism( l ) and IsOne( l ) ) );
    
    if L = [ ] then
        L := [ l ];
    fi;
    
    L := DuplicateFreeList( L );
    
    R := UnderlyingRing( CapCategory( l ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        L := List( L, I -> AsCategoryOfRowsMorphism( R_elim * UnderlyingMatrix( I ) ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                ListOfMorphismsOfRank1RangeOfUnderlyingCategory, L,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsClosedSubobject, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                ListOfMorphismsOfRank1RangeOfUnderlyingCategory, L,
                UnderlyingRing, R,
                IsClosedSubobject, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a CAP category morphism",
        [ IsCapCategoryMorphism ],

  function( I )
    local R, R_elim, A, ZC, B;
    
    R := UnderlyingRing( CapCategory( I ) );
    
    R_elim := PolynomialRingWithProductOrdering( R );
    
    if not IsIdenticalObj( R_elim, R ) then
        I := AsCategoryOfRowsMorphism( R_elim * UnderlyingMatrix( I ) );
        R := R_elim;
    fi;
    
    A := rec( );
    
    ZC := ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R );
    
    B := BaseRing( R );
    
    if not IsIdenticalObj( R, B ) then
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                StandardMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                BaseOfFibration, TerminalObject( ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( B ) ),
                IsClosedSubobject, true
                );
    else
        ObjectifyObjectForCAPWithAttributes( A, ZC,
                StandardMorphismOfUnderlyingCategory, I,
                UnderlyingRing, R,
                IsClosedSubobject, true
                );
    fi;
    
    Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a homalg matrix",
        [ IsHomalgMatrix ],

  function( mat )
    
    return ClosedSubsetOfSpecByStandardMorphism( AsCategoryOfRowsMorphism( mat ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a homalg ring element",
        [ IsHomalgRingElement ],

  function( r )
    
    return ClosedSubsetOfSpecByStandardMorphism( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );

end );
    
##
InstallMethod( ClosedSubsetOfSpec,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return ClosedSubsetOfSpec( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByReducedMorphism,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return ClosedSubsetOfSpecByReducedMorphism( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ClosedSubsetOfSpecByStandardMorphism,
        "for a string and a homalg ring",
        [ IsString, IsHomalgRing ],

  function( str, R )
    
    return ClosedSubsetOfSpecByStandardMorphism( StringToHomalgColumnMatrix( str, R ) );
    
end );

##
InstallMethod( ZariskiCoframeOfAffineSpectrumUsingCategoryOfRows,
        "for a homalg ring",
        [ IsHomalgRing ],
        
  function( R )
    local name, ZariskiCoframe;
    
    R := PolynomialRingWithProductOrdering( R );
    
    name := "The coframe of Zariski closed subsets of the affine spectrum of ";
    
    name := Concatenation( name, RingName( R ) );
    
    ZariskiCoframe := CreateCapCategory( name );
    
    SetUnderlyingRing( ZariskiCoframe, R );
    
    ZariskiCoframe!.UnderlyingCategory := CategoryOfRows( R );
    
    ZariskiCoframe!.Constructor := ClosedSubsetOfSpec;
    ZariskiCoframe!.ConstructorByListOfMorphismsOfRank1Range := ClosedSubsetOfSpecByListOfMorphismsOfRank1Range;
    ZariskiCoframe!.ConstructorByReducedMorphism := ClosedSubsetOfSpecByReducedMorphism;
    ZariskiCoframe!.ConstructorByStandardMorphism := ClosedSubsetOfSpecByStandardMorphism;
    
    AddObjectRepresentation( ZariskiCoframe, IsObjectInZariskiCoframeOfAnAffineVariety );
    
    AddMorphismRepresentation( ZariskiCoframe, IsMorphismInZariskiCoframeOfAnAffineVariety );
    
    ADD_COMMON_METHODS_FOR_COHEYTING_ALGEBRAS( ZariskiCoframe );
    
    ADD_COMMON_METHODS_FOR_FRAMES_AND_COFRAMES_DEFINED_USING_CategoryOfRows( ZariskiCoframe );
    
    ##
    AddIsHomSetInhabited( ZariskiCoframe,
      IsHomSetInhabitedForCoframesUsingCategoryOfRows );
    
    ##
    if IsBound( homalgTable( R )!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ##
        AddIsEqualForObjectsIfIsHomSetInhabited( ZariskiCoframe,
          IsEqualForObjectsIfIsHomSetInhabitedForCoframesUsingCategoryOfRows );
        
    fi;
    
    ##
    AddTerminalObject( ZariskiCoframe,
      function( arg )
        local T;
        
        T := ClosedSubsetOfSpecByStandardMorphism( HomalgZeroMatrix( 0, 1, R ) );
        
        SetIsTerminal( T, true );
        
        return T;
        
    end );
    
    ##
    AddInitialObject( ZariskiCoframe,
      function( arg )
        local I;
        
        I := ClosedSubsetOfSpecByStandardMorphism( HomalgIdentityMatrix( 1, R ) );
        
        SetIsInitial( I, true );
        
        return I;
        
    end );
    
    ##
    AddIsTerminal( ZariskiCoframe,
      function( A )
        
        return IsZero( MorphismOfRank1RangeOfUnderlyingCategory( A ) );
        
    end );
    
    ##
    AddIsInitial( ZariskiCoframe,
      function( A )
        local mor, one;
        
        mor := ListOfMorphismsOfRank1RangeOfUnderlyingCategory( A );
        
        ## avoid the warning "an empty matrix is about to get evaluated!"
        List( mor, IsZero );
        
        one := StandardMorphismOfUnderlyingCategory( InitialObject( A ) );
        
        return ForAll( mor, m -> IsLiftable( one, m ) );
        
    end );
    
    ##
    AddCoproduct( ZariskiCoframe,
      function( L )
        
        if Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, ListOfMorphismsOfRank1RangeOfUnderlyingCategory );
        
        L := Concatenation( L );
        
        return ClosedSubsetOfSpecByListOfMorphismsOfRank1Range( L );
            
    end );
    
    ##
    AddDirectProduct( ZariskiCoframe,
      function( L )
        local P;
        
        L := MaximalObjects( L, IsSubset );
        
        if Length( L ) = 1 then
            return L[1];
        fi;
        
        L := List( L, MorphismOfRank1RangeOfUnderlyingCategory );
        
        P := UniversalMorphismFromDirectSum( L );
        
        return ClosedSubsetOfSpec( P );
        
    end );
    
    ## the closure of the set theortic difference
    AddCoexponentialOnObjects( ZariskiCoframe,
      function( A, B )
        local L;
        
        B := MorphismOfUnderlyingCategory( B );
        
        if IsZero( B ) then
            return InitialObject( A );
        fi;
        
        A := MorphismOfUnderlyingCategory( A );
        
        A := UnderlyingMatrix( A );
        B := UnderlyingMatrix( B );
        
        L := List( [ 1 .. NrRows( B ) ], r -> SyzygiesGeneratorsOfRows( CertainRows( B, [ r ] ), A ) );
        
        L := List( L, ClosedSubsetOfSpecByReducedMorphism );
        
        return Coproduct( L );
        
    end );
    
    Finalize( ZariskiCoframe );
    
    SetZariskiCoframeOfAffineSpectrumUsingCategoryOfRows( R, ZariskiCoframe );
    
    return ZariskiCoframe;
    
end );

##
InstallMethod( IsOpen,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],

  function( A )
    
    return IsClosed( -A );
    
end );

##
InstallMethod( Dimension,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],

  function( A )
    
    return AffineDimension( UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) ) );
    
end );

##
InstallMethod( DegreeAttr,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframeOfAnAffineVariety ],

  function( A )
    
    return AffineDegree( UnderlyingMatrix( MorphismOfUnderlyingCategory( A ) ) );
    
end );

##
InstallMethod( AClosedSingleton,
        "for an object in a Zariski coframe of an affine variety",
        [ IsObjectInZariskiCoframe and IsObjectInZariskiFrameOrCoframeOfAnAffineVariety ],
        
  function( A )
    local C;
    
    if IsInitial( A ) then
        Error( "the input A is empty\n" );
    fi;
    
    C := CapCategory( A );
    
    A := UnderlyingMatrix( StandardMorphismOfUnderlyingCategory( A ) );
    
    A := AMaximalIdealContaining( A );
    
    A := C!.ConstructorByReducedMorphism( A );
    
    return A;
    
end );

##
InstallMethod( TangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a homalg matrix",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsHomalgMatrix ],
        
  function( gamma, point )
    local R, T, var;
    
    R := UnderlyingRing( gamma );
    
    gamma := UnderlyingMatrix( MorphismOfUnderlyingCategory( gamma ) );
    
    T := TangentSpaceByEquationsAtPoint( gamma, point );
    
    var := Indeterminates( R );
    
    T := ( R * T ) * HomalgMatrix( var, Length( var ), 1, R );
    
    return ClosedSubsetOfSpecByReducedMorphism( T );
    
end );

##
InstallMethod( TangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a list",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsList ],
        
  function( gamma, point )
    local R, k;
    
    R := UnderlyingRing( gamma );
    
    k := CoefficientsRing( R );
    
    point := HomalgMatrix( point, Length( point ), 1, k );
    
    return TangentSpaceAtPoint( gamma, point );
    
end );

##
InstallMethod( ComplementOfTangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a homalg matrix",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsHomalgMatrix ],
        
  function( gamma, point )
    local R, T, C, var;
    
    R := UnderlyingRing( gamma );
    
    gamma := UnderlyingMatrix( MorphismOfUnderlyingCategory( gamma ) );
    
    T := TangentSpaceByEquationsAtPoint( gamma, point );
    
    C := MatrixOfGenerators( ByASmallerPresentation( LeftPresentation( T ) ) );
    
    var := Indeterminates( R );
    
    C := ( R * C ) * HomalgMatrix( var, Length( var ), 1, R );
    
    return ClosedSubsetOfSpecByReducedMorphism( C );
    
end );

##
InstallMethod( ComplementOfTangentSpaceAtPoint,
        "for an object in a Zariski coframe of an affine variety and a list",
        [ IsObjectInZariskiCoframeOfAnAffineVariety, IsList ],
        
  function( gamma, point )
    local R, k;
    
    R := UnderlyingRing( gamma );
    
    k := CoefficientsRing( R );
    
    point := HomalgMatrix( point, Length( point ), 1, k );
    
    return ComplementOfTangentSpaceAtPoint( gamma, point );
    
end );
