global cvtt2n

segment .data
    conversion dq 0.25     ; 1 tic = 0.25 nanoseconds

segment .text

cvtt2n:
    ; input: xmm0 = tics
    ; output: xmm0 = nanoseconds

    mulsd xmm0, [rel conversion]
    ret
