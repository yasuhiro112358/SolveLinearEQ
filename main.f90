! **************************
! コンパイル方法
! ```
! gfortran main.f90 -llapack
! ```
! 事前にgccとlapackのインストールが必要
! **************************

program solve_linear_equations
    implicit none
    ! LAPACKルーチンDGESVを使用するためのパラメーター
    integer, parameter :: n = 3  
    ! 左辺の行列Aの次元（3は3x3を示す）
    integer, parameter :: nrhs = 1  
    ! 右辺のベクトルBの数（1は1つの連立方程式を解くことを示す）
    integer, parameter :: lda = n  
    ! Leading Dimension of A（行列・ベクトルでは行数を示す）
    integer, parameter :: ldb = n  
    ! Leading Dimension of B（行列・ベクトルでは行数を示す）
    integer :: info  
    ! 出力情報（DGESV関数の実行後にエラー情報を格納する変数）
    integer :: ipiv(n)  ! ピボット配列
    ! ipiv配列は、ピボット選択のプロセスで行われる行の入れ替え情報を記録する。具体的には、LU分解の過程で、どの行がどの行と入れ替えられたのか、その履歴がこの配列に格納される。配列の各要素は、対応する行が分解過程でどの位置に移動したかを示す整数値を持つ。

    ! A行列とBベクトルの定義
    double precision :: A(lda, n) = reshape([4.0d0, 2.0d0, 1.0d0, &
                                             4.0d0, -2.0d0, 4.0d0, &
                                             1.0d0, 1.0d0, -1.0d0], &
                                             [lda, n])
    double precision :: B(ldb, nrhs) = reshape([7.0d0, 9.0d0, -5.0d0], [ldb, nrhs])
    ! reshapeを使用する場合、数学での記述とは行と列が反転される。
    ! DGESVにおける行列Aの1行目はA(1,*)である。
    ! 一方でreshapeはA(*,1)のように1列目からデータを受け取っていく。

    print *, '行列Aは: '
    print *, A
    print *, 'ベクトルBは: '
    print *, B

    ! LAPACKルーチンの呼び出し
    call DGESV(n, nrhs, A, lda, ipiv, B, ldb, info)

    ! 解の出力
    if (info == 0) then
        print *, '解は: '
        print *, B
    else
        print *, 'エラー: 情報=', info
    end if
end program solve_linear_equations