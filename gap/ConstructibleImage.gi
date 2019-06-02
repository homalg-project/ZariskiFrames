#
# ZariskiFrames: Constructible image
#
# Implementations
#

##
SetInfoLevel( InfoConstructibleImage, 1 );

##
InstallMethod( DecreaseCodimensionByFixingVariables,
        "for an object in a Zariski coframe",
        [ IsObjectInZariskiCoframe ],
        
  function( Gamma )
    local R, B, var, n, values, modify_hyperplanes, i, Gamma0, nrFails, image_closure,
          d0, fiber_dim, additional_components, L, a, H, j, Gamma0_test, Gamma0_image, Gamma0_image_test;

    R := UnderlyingRing( Gamma );

    B := BaseRing( R );
    
    var := ShallowCopy( RelativeIndeterminatesOfPolynomialRing( R ) );

    n := Length( var );

    values := [ 0, 1, -1, 2, -2, 3, -3, 5, -5, 7, -7, 11, -11, 13, -13, 17, -17, 19, -19, 42, -42 ];

    modify_hyperplanes := ValueOption( "modify_hyperplanes" );
    if IsInt( modify_hyperplanes ) then
        values := Concatenation( values, [ 43 .. 44 + modify_hyperplanes ] );
        for i in [ 1 .. modify_hyperplanes ] do
            var := Permuted( var, PermList( Concatenation( [ n ], [ 1 .. n-1 ] ) ) );
            Remove( values, 1 );
        od;
    fi;

    values := Concatenation( values, ListWithIdenticalEntries( 10, "random" ) );

    # We intersect Gamma with hyperplanes until the codimension in the fiber is zero without changing the closure of the image
    # The result is stored in Gamma 0, which we successively build by intersecting with hyperplanes of codimension 1
    Gamma0 := Gamma;

    nrFails := 0;

    image_closure := ImageClosureOfProjection( Gamma );

    d0 := Dimension( image_closure );

    fiber_dim := Dimension( Gamma ) - d0;

    additional_components := [];

    L := TerminalObject( Gamma );

    for a in values do

        i := 1;
        while i <= n and fiber_dim > 0 do

            if IsInt( a ) then
                H := var[i] - a;
            else
                # This catches the string "random"
                # Generate a random linear equation
                H := Zero( R );
                for j in [ 1 .. n ] do
                    H := H + Random([-100..100]) * var[j];
                od;
                H := H + Random([-100..100]);
            fi;
            # A Hyperplane of codimension 1
            H := ClosedSubsetOfSpecByReducedMorphism( H );
            L := L * H;

            # This is only a candidate at this point
            Gamma0_test := Gamma0 * H;
            
            if Dimension( Gamma0_test ) = d0 + fiber_dim - 1 then # Check, whether the intersection with H really reduces the codimension

                Gamma0_image := ImageClosureOfProjection( Gamma0_test );

                if IsSubset( Gamma0_image, image_closure ) then # Check, whether the closure of the image remains the same

                    # We are in the good case, where intersecting with H reduced the codimension in the fiber and does not change the closure of the image.
                    # Hence we permanently incorporate H in Gamma0
                    Gamma0 := Gamma0_test;
                    Remove( var, i );
                    n := n - 1;
                    fiber_dim := fiber_dim - 1;
                    nrFails := 0;
                    Info( InfoConstructibleImage, 4, "hyperplane ", EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( H ) ) ), " works. Fiber dim: ", fiber_dim );
                    Assert( 4, fiber_dim=0 or ImageOfProjection( PointsAtInfinityOfFiberwiseProjectiveClosure( Gamma0 ) ) = image_closure );


                else

                    Info( InfoConstructibleImage, 4, "hyperplane ", EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( H ) ) ), " decreases image" );

                    # This case is intended to split of cases with components of high fiber dimension, but low image dimension
                    # Do not do it too early or often, since it is (a) expensive and (b) tends to produce irrelevant components
                    if nrFails > 2*n then
                        Info( InfoConstructibleImage, 4, "try splitting fiber..." );
                        Gamma0_image_test := CoexponentialOnObjects( image_closure, Gamma0_image );
                        Info( InfoConstructibleImage, 4, "...done" );
                        Info( InfoConstructibleImage, 4, "check split..." );
                        if not IsSubset( Gamma0_image_test, image_closure ) and not IsInitial( Gamma0_image_test ) then
                            Info( InfoConstructibleImage, 4, "...done (yes)" );
                            Info( InfoConstructibleImage, 4, "split of components in the fiber..." );
                            Assert( 4, image_closure = Gamma0_image + Gamma0_image_test );
                            # We continue with one of the components, but might need to recompute values
                            Gamma0 := PreimageOfProjection( Gamma, Gamma0_image );
                            image_closure := Gamma0_image;
                            Assert( 4, image_closure = ImageClosureOfProjection( Gamma0 ) );
                            d0 := Dimension( image_closure );
                            fiber_dim := Dimension( Gamma0 ) - d0;
                            # Write the second component into additional components
                            Append( additional_components, [ PreimageOfProjection( Gamma, Gamma0_image_test ) ] );
                            Assert( 4, Gamma = PreimageOfProjection( Gamma, Gamma0_image_test ) + Gamma0 );
                            Assert( 4, not Gamma = Gamma0 );
                            Assert( 4, not Gamma = PreimageOfProjection( Gamma, Gamma0_image_test ) );
                            nrFails := 0;
                            Info( InfoConstructibleImage, 4, Concatenation( "...done (back to fiber dimension ", String( fiber_dim ), ")" ) );

                        else
                            Info( InfoConstructibleImage, 4, "...done (no)" );
                        fi;
                    fi;

                    i := i + 1;
                    nrFails := nrFails + 1;

                fi;

            else

                Info( InfoConstructibleImage, 4, "hyperplane ", EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( H ) ) ), " does not decrease dimension" );
                i := i + 1;
                nrFails := nrFails + 1;

            fi;

        od;
            
        if fiber_dim = 0 then
            break;
        fi;

    od;

    return [ Gamma0, additional_components, L ];

end );

##
InstallMethod( LocallyClosedProjection,
        "for an object in a Zariski coframe",
        [ IsObjectInZariskiCoframe ],
        
  function( Gamma )
    local counter, step, d, image_closure, d0, fiber_dim, Gamma0, additional_components,
          l, decomposition, frame, smaller_frame, i;

    counter := ValueOption( "counter" );
    
    if counter = fail then
        step := "";
        counter := "";
    else
        step := "Step ";
    fi;
    
    Info( InfoConstructibleImage, 3, step, counter, " dimension..." );
    d := Dimension( Gamma );
    Info( InfoConstructibleImage, 3, step, counter, " ...done" );

    Info( InfoConstructibleImage, 3, step, counter, " image closure..." );
    image_closure := ImageClosureOfProjection( Gamma );
    Info( InfoConstructibleImage, 3, step, counter, " ...done" );

    Info( InfoConstructibleImage, 3, step, counter, " dimension..." );
    d0 := Dimension( image_closure );
    Info( InfoConstructibleImage, 3, step, counter, " ...done" );
   
    fiber_dim := d - d0;

    additional_components := [];

    Info( InfoConstructibleImage, 2, step, counter, " ", d0, "+", fiber_dim );

    Gamma0 := Gamma;

    if fiber_dim > 0 then
 
        # Gamma0 satisfies two conditions
        # (i) It has the same image closure as Gamma
        # (ii) We have reason to believe that the fibers have dimension zero (on at least a component of the image closure)
        l := DecreaseCodimensionByFixingVariables( Gamma0 );
        Gamma0 := l[1];
       
        # This Gamma0 cannot be constructed in all cases
        # The restrictions lie on additional components, which could not be treated, and are instead collected here
        if Length( l[2] ) > 0 then

            Append( additional_components, l[2] );

            # if additional components are present, then the image needs to be recomputed
            Info( InfoConstructibleImage, 3, step, counter, " image closure..." );
            image_closure := ImageClosureOfProjection( Gamma0 );
            Info( InfoConstructibleImage, 3, step, counter, " ...done" );

            Info( InfoConstructibleImage, 3, step, counter, " dimension..." );
            d0 := Dimension( image_closure );
            Info( InfoConstructibleImage, 3, step, counter, " ...done" );

        fi;

        Info( InfoConstructibleImage, 3, step, counter, " dimension..." );
        d := Dimension( Gamma0 );
        Info( InfoConstructibleImage, 3, step, counter, " ...done" );

        fiber_dim := d - d0;

        Info( InfoConstructibleImage, 2, step, counter, " ", d0, "+", fiber_dim );

    fi;

    # Sometimes (rarely!), we fail to reduce the dimension in the fibers to zero
    # This should not happen, if Gamma0 is irreducible
    # Hence, we compute its associated primes here, and treat them all indepedently
    if fiber_dim > 0 then

        Info( InfoConstructibleImage, 3, step, counter, " unlucky decomposition in total space..." );
        decomposition := Factors( Gamma0 );
        Info( InfoConstructibleImage, 3, step, counter, " ...done" );

        if Length( decomposition ) = 1 then

            if fiber_dim > 0 then
                Error( "give up in trying to bring the fiber dimension down to 0" );
            fi;

        else

            Gamma0 := decomposition[1];
            Append( additional_components, decomposition{[2..Length(decomposition)]} );

            # if additional components are present, then the image needs to be recomputed
            Info( InfoConstructibleImage, 3, step, counter, " image closure..." );
            image_closure := ImageClosureOfProjection( Gamma0 );
            Info( InfoConstructibleImage, 3, step, counter, " ...done" );

            Info( InfoConstructibleImage, 3, step, counter, " dimension..." );
            d0 := Dimension( image_closure );
            Info( InfoConstructibleImage, 3, step, counter, " ...done" );

        fi;

    fi;
 
    Info( InfoConstructibleImage, 3, step, counter, " points at infinity..." );
    frame := PointsAtInfinityOfFiberwiseProjectiveClosure( Gamma0 );
    Info( InfoConstructibleImage, 3, step, counter, " ...done" );

    Info( InfoConstructibleImage, 3, step, counter, " frame..." );
    frame := ImageOfProjection( frame );
    Info( InfoConstructibleImage, 3, step, counter, " ...done" );

    Info( InfoConstructibleImage, 5, "Step ", counter, " frame: ", EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( frame ) ) ) );
    
    smaller_frame := ValueOption( "smaller_frame" );
    
    if IsInt( smaller_frame ) and IsEmpty( additional_components ) then
        for i in [ 1 .. smaller_frame ] do
            l := DecreaseCodimensionByFixingVariables( Gamma : modify_hyperplanes := i );
            if IsEmpty( l[2] ) then
                l := PointsAtInfinityOfFiberwiseProjectiveClosure( l[1] );
                l := ImageOfProjection( l );
                frame := frame * l;
                StandardMorphismOfUnderlyingCategory( frame );
                Info( InfoConstructibleImage, 5, "Step ", counter, " frame: ", EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( frame ) ) ) );
            else
                Info( InfoConstructibleImage, 2, "Step ", counter, " break" );
                break;
            fi;
        od;
    fi;

    Assert( 4, not IsSubset( frame, image_closure ) );
    Assert( 4, IsSubset( image_closure, frame ) );
    
    return [ image_closure - frame, additional_components ];
    
end );

##
InstallMethod( ConstructibleProjection,
        "for an object in a Zariski coframe",
        [ IsObjectInZariskiCoframe ],
        
  function( Gamma )
    local B, initial, C, node, counter, decomposition, frame_decomposition,
          additional_components, components, image_closure_and_frame, neg_node,
          pre_nodes, image_closure, frame, frame_decomp, pos_node, squash;
    
    B := BaseOfFibration( Gamma );
    
    initial := InitialObject( B );
    
    initial := UnionOfMultipleDifferences( initial - initial );
    
    C := DatastructureForConstructibleObject( );
    
    C!.InitialObject := initial;
    
    node := NodeInDatastructureOfConstructibleObject( C, B, fail : number := 0 );
    
    node!.Gamma := Gamma;
    
    counter := -1;
    
    decomposition := ValueOption( "decomposition" );
    
    frame_decomposition := ValueOption( "frame_decomposition" );
    
    while not IsDone( C ) do
        
        node := Pop( C );
        
        counter := counter + 1;
        
        Info( InfoConstructibleImage, 2, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" );
        Info( InfoConstructibleImage, 2, "Step ", counter, " processing pre/negative node number ", node!.number );
        
        Gamma := node!.Gamma;

        additional_components := [];

        if decomposition = true then
            Info( InfoConstructibleImage, 4, "Step ", counter, " decompotition... " );
            components := Factors( Gamma );
            Info( InfoConstructibleImage, 4, "Step ", counter, " ...done (# = ", Length( components ), ")" );
            Gamma := components[1];
            additional_components := Concatenation( additional_components, components{[ 2 .. Length( components ) ]} );
        else
            Info( InfoConstructibleImage, 4, "Step ", counter, " existing partial decompotition... " );
            components := KnownFactors( Gamma );
            Info( InfoConstructibleImage, 4, "Step ", counter, " ...done (# = ", Length( components ), ")" );
            Gamma := components[1];
            additional_components := Concatenation( additional_components, components{[ 2 .. Length( components ) ]} );
        fi;
        
        Info( InfoConstructibleImage, 4, "Step ", counter, " intersect with preimage... " );
        Gamma := PreimageOfProjection( Gamma, node!.object );
        Info( InfoConstructibleImage, 4, "Step ", counter, " ...done " );
        
        Info( InfoConstructibleImage, 4, "Step ", counter, " decide triviality... " );
        if IsInitial( Gamma ) then
            Info( InfoConstructibleImage, 4, "Step ", counter, " ...done (yes)" );
            continue;
        fi;
        Info( InfoConstructibleImage, 4, "Step ", counter, " ...done (no)" );
        
        image_closure_and_frame := LocallyClosedProjection( Gamma : counter := counter );
        
        additional_components := Concatenation( additional_components, image_closure_and_frame[2] );
        
        if Length( additional_components ) > 0 then
            
            Info( InfoConstructibleImage, 2, "Step ", counter, " found ", Length( additional_components ), " additional component(s) of dimension(s) ", List( additional_components, Dimension ) );
            
            neg_node := node!.act_parents;
            
            if not Length( neg_node ) = 1 then
                Error( "the list node!.act_parents must contain exactly one (negative) node\n" );
            fi;
            
            neg_node := neg_node[1];
            
            pre_nodes := List( [ 1 .. Length( additional_components ) ], i -> NodeInDatastructureOfConstructibleObject( C, node!.object, fail : parents := [ neg_node ], number := Concatenation( String( neg_node!.number ), "_", String( i ) ), first := true ) );
            
            Perform( [ 1 .. Length( additional_components ) ], function( i ) pre_nodes[i]!.Gamma := additional_components[i]; end );
            
        fi;
        
        image_closure := image_closure_and_frame[1].I;
        
        frame := image_closure_and_frame[1].J;
        
        frame_decomp := [];

        if not frame_decomposition = false then
            if not IsInitial( frame ) then
                Info( InfoConstructibleImage, 4, "Step ", counter, " frame decomposition... " );
                frame_decomp := Factors( frame );
                Info( InfoConstructibleImage, 4, "Step ", counter, " ...done (# = ", Length( frame_decomp ), ")" );
            fi;
        else
            if not IsInitial( frame ) then
                Info( InfoConstructibleImage, 4, "Step ", counter, " existing frame partial decomposition... " );
                frame_decomp := KnownFactors( frame );
                Info( InfoConstructibleImage, 4, "Step ", counter, " ...done (# = ", Length( frame_decomp ), ")" );
            fi;
        fi;
       
        pre_nodes := Attach( node, image_closure, frame_decomp );
        
        pos_node := pre_nodes[2];
        pre_nodes := pre_nodes[1];
        
        Perform( pre_nodes, function( pre_node ) pre_node!.Gamma := Gamma; end );
        Info( InfoConstructibleImage, 2, "Step ", counter, " need to treat ", Length( pre_nodes ), " additional components." );
        
        Info( InfoConstructibleImage, 4, "Step ", counter, " produced negative nodes ",
              List( pre_nodes, a -> a!.number ), " -> ", pos_node!.number, " -> ", node!.number );
        
        Info( InfoConstructibleImage, 5, "Step ", counter, " image: ", EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( image_closure ) ) ), " frame: ", EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( frame ) ) ), " (", List( frame_decomp, f -> EntriesOfHomalgMatrix( UnderlyingMatrix( MorphismOfUnderlyingCategory( f ) ) ) ), ")" );
        
    od;
    
    C!.finalized := true;
    
    squash := ValueOption( "squash" );
    
    if not squash = false then
        Squash( C );
    fi;
    
    return AsUnionOfMultipleDifferences( C );
    
end );

##
InstallMethod( ConstructibleProjection,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    
    A := AsMultipleDifference( A );
    
    return ConstructibleProjection( A );
    
end );

##
InstallMethod( ConstructibleProjection,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local Ac, im, imc, Ap, a;
    
    A := StandardizeObject( A );
    
    A := Factors( A );
    
    if Length( A ) > 1 then
        A := List( A, ConstructibleProjection );
        A := CallFuncList( UnionOfMultipleDifferences, A );
        A := CanonicalObject( A );
        A := FactorizedObject( A );
        return A;
    fi;
    
    A := A[1];
    
    Ac := A.I;
    
    im := ConstructibleProjection( Ac );
    
    imc := Closure( im );
    
    Ap := List( A, a -> a.J );
    
    Ap := List( Ap, ImageClosureOfProjection );
    
    Ap := Filtered( Ap, a -> not IsHomSetInhabited( imc, a ) );
    
    if Ap = [ ] then
        return im;
    fi;
    
    for a in Ap do
        im := im - a;
    od;
    
    Ap := List( Ap, a -> PreimageOfProjection( Ac, a ) );
    
    A := A * Coproduct( Ap );
    
    A := CanonicalObject( A );
    
    A := FactorizedObject( A );
    
    A := im + ConstructibleProjection( A );
    
    A := CanonicalObject( A );
    
    A := FactorizedObject( A );
    
    return A;
    
end );

##
InstallOtherMethod( DotVertexLabelledDigraph,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    if not IsBound( A!.C ) then
        Print( "no datastructure of a constructible object found\n" );
    fi;
    
    return DotVertexLabelledDigraph( A!.C );
    
end );

##
InstallMethod( Visualize,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    if not IsBound( A!.C ) then
        Print( "no datastructure of a constructible object found\n" );
    fi;
    
    Visualize( A!.C );
    
end );

##
InstallMethod( VisualizeInJulia,
        "for a constructible object",
        [ IsConstructibleObject ],
        
  function( A )
    
    if not IsBound( A!.C ) then
        Print( "no datastructure of a constructible object found\n" );
    fi;
    
    VisualizeInJulia( A!.C );
    
end );
