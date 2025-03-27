#import "@preview/lovelace:0.3.0": *

#let title = "Scalable Parallel-in-Time Integration for Equations of Motion"
#let gets   = sym.arrow.l
#let cn     = text(red)[*CN*]

#set page(
  paper: "us-letter",
  margin: (top: auto, rest: 0.625in),
  numbering: "1/1",
  header: context {
    let sections = query(
      selector(heading.where(level: 2)).before(here())
    )
    if sections != () {
      let lastSection = sections.last()
      // let number = counter(heading).at(lastSection.location())
      [#emph(smallcaps(title)) #h(1fr) #emph(smallcaps(lastSection.body)) #line(length: 100%)]
    }
  }
)
#set par(justify: true, leading: 1em)
#set text(font: "New Computer Modern", size: 10pt)
#set enum(numbering: "1)")
#set heading(numbering: "1.")
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}
#set document(
  title: [title],
  author: "Nathan Chapman"
)
#set math.equation(numbering: "(1)", supplement: [Eq.])

// #show link: set text(fill: blue, style: "italic")
// #show link: lnk => underline(lnk)

// TITLE
#v(1fr)
#align(center)[
  #text(size: 15pt)[*#title*]
  #v(1em)
  Nathaniel Chapman#super[1]\
  #super[1]Department of Computer Science, Central Washington University\
  #datetime.today().display("[month repr:long] [day], [year]")
]

#v(1em)
#align(center)[
  #set par(justify: false)
  *Abstract*\
  Simulating time-dependent physics has traditionally been constrained to using sequential algorithms, thus not benefiting from advances in parallel computing.
  Parallel-in-time integration attempts to address this limitation with methods such as the Parareal algorithm.
  As the performance of the Parareal algorithm scales with the number of processors, it is well-suited to use the massively-parallel nature of graphics processing units.
  Additional performance gains are seen when the physics is wave-like, as using a spectral method allows for each node in a distributed system to evaluate the Parareal algorithm.
]
#v(1fr)
#pagebreak()

// TABLE OF CONTENTS
#outline(indent: auto)
#pagebreak()

= Introduction

= Background

== Parallel-in-Time Integration (PinT)

There are 3 traditional ways to parallelize the solution of a computational problem: 
CPU parallelization, 
GPU parallelization, 
and Distributed computing.  
While CPU parallelization is more straightforward to implement, GPU parallelization can allow for runtimes to decrease by many orders of magnitudes.
Even lower run times can be achieved by combining either of these parallization schemes with running them on multiple machines.  This investigation focuses on parallelizing the solution of equations of motion using GPUs and multiple machines.

These approaches can offer massive increases in performance, but only for problems that are well-posed to be parallelized.  Traditionally, initial value problems have been unable to be parallelized due their dependance on causality.  Several methods have been created to overcome this limitation.  These methods include the Parareal algorithm, Multigrid Reduction in Time (MGRIT), Parallel Full Approximtaion Scheme in Space and Time (PFASST).  This investigation focuses on the Parareal algorithm.

=== Parareal
- The Parareal method has mostly been applied to first-order ordinary differential equations.
- Part of the novelty of this work is that it focuses on building support for second-order ODES

=== Multigrid Reduction in Time (MGRIT)

=== Parallel Full Approximation Scheme in Space and Time (PFASST)

== High-Performance Computing

Some key aspects of high-performance computing (HPC) are:
=== Multi-threading & GPU Computing
=== Multi-processing & Distributed Computing

== Equations of Motion

=== Differential Equations
- Ordinary Differential Equations (ODE)
- Systems of ODEs e.g. N-Body
  - uncoupled
  - coupled
- Partial Differential Equations (PDE) e.g. wave equation

=== Traditional Numerical Methods
- ODEs
  - Symplectic Integration
  - Traditional Methods in evoling Equations of Motion
  - Def don't use Runge-Kutta methods
  - Symplectic Euler
  - Velocity Verlet
  - etc.
- PDEs
  - Method of Lines
  - Method of Relaxation

= Methods

Simulating physical processes has traditionally been done sequentially; even during the modern age of hardware supporting parallel execution, using computers to calculate the evolution of physical phenomena has been sequential.  Why haven't scientists just started doing things in parallel? Because of that pesky thing call _causality_; _the ball must go up before it can come down_.  Because of this temporal dependence (spatial dependence has had its own workarounds such as the Barnes-Hut algorithm @Barnes1986 @Hamada2009), simulation of large-time-scale physics has thus taken a long time to execute.  The Parareal algorithm (PA), and other parallel-in-time integration algorithms, have been developed in the last few decades #cn to specifically address this issue.  

Many details and variations of the Parareal algorithm have been investigated to find and address issues such as stability #cn, convergence rates #cn, application to higher-order differential equations #cn.  The main goal of this investigation is to contribute another variation: an implementation of the Parareal algorithm using methods from high-performance computing.

Before the PA can be implemented using these high-performance methods, the algorithm must be decomposed into its central components.  The Parareal algorithm begins by partitioning a single IVP into several IVPs on smaller domains via an initial, inaccurate, "root" solution.  Then each of the "subproblems" are solved using a sequential, accurate method on different threads at the same time.  The final data for each of the subsolutions is then combined with the respective data of the root solution to yield a more accurate (i.e. "corrected") root solution.  This new root solution is then used to repeat the process until convergence.

The interpretation of the PA in terms of these recursive subproblems makes the algorithm _almost_ embarrassingly parallel; the corrections to the root solution need to be done sequentially.  In addition to this structure, the algorithms being evaluated in parallel manifestly depend on simple arithmetic; because of this simplicity, the PA is well-suited to be evaluated on the GPU.  Likewise, distributed methods can be combined with GPU evaluation for further parallelization for either a single model (taking advantaged of the recursive nature of the PA) or a system of models.

*Example Parameters:* Consider the motion of a simple pendulum over the course of 10 seconds, starting at rest with an angle of $pi/8$, is to be simulated on a machine with 10 available threads.  The root initial value problem for this physical scenario can be modeled by:

$ P = {
  underbrace(
    diff_t^2 theta = -g/ell theta, 
    "Acceleration"
  ), #h(11pt)  
  underbrace(
    theta(0) = pi/8\,  v(0) = 0 "rad/s", 
    "Initial values"
  ), #h(11pt) 
  underbrace(
    [0 "s", 10 "s"], 
    "time span"
  )
}. $

== The Parareal Algorithm

#v(2em)
#align(right, [_The Parareal Algorithm aimed to solve the problem of physics taking too long to simulate; it didn't._])
#v(2em)

The main idea of the Parareal algorithm (PA) is to break up a single IVP into many smaller IVPs using some low-accuracy solution, solve those in parallel using high-accuracy methods, correct your initial solution using the sub-solutions, then make a new low-accuracy solution based on the corrected data, and repeat this process until the solution doesn't change.  The end result of this procedure is a solution identical to one produced by directly using the high-accuracy method #cn while taking a less time.  Because the PA wraps traditional (sequential) solvers, it could be considered a "meta-" or "higher-order" method to solve IVPs.

=== Subproblem Preparation

Let the second-order initial value problem $P$ be defined such that

$ P = {cal(L)(t, u, diff_t u, diff_t^2 u) = f(t), #h(11pt)  u(0) = u_0,  diff_t u(0) = v_0, #h(11pt) [t_0, t_0 + Delta t]}, $ <IVP>

and $D = [t_0, t_0 + Delta t]$. The discretization $N$ of $P$ should be determined by the number of available threads $N_t$ such that $N = m N_t$, for some positive integer $m$.  The discretization should be chosen in this manner for maximum performance and efficiency; if $N = m N_t + r$, and $0 < r < N_t$, each thread will solve a subproblem $m$ times until on the $m+1$ iteration where only $r$ threads would be active while $N_t - r$ threads idle (assuming all threads are synchronized).  This type of optimization is sometimes referred to as "_flooding the threadpool_" to mitigate _thread starvation_ #cn.

With the discretization decided, partition the time domain $D$ into subdomains $D_p$ such that

$ D_p = [t_0 + p / N Delta t, t_0 + (p + 1) / N Delta t] = [t_p, t_(p+1)]. $

Use a coarse propagator $cal(C)_0$ (such as the Euler method) to compute initial (represented by the $0$ subscript) root solutions ${u_p^0}_p$, ${v_p^0}_p$ defined such that

$ {u_p^0}_p = {u_0^0, u_1^0, u_2^0, dots, u_(N-1)^0} $
$ {v_p^0}_p = {v_0^0, v_1^0, v_2^0, dots, v_(N-1)^0} $

and ${u_p^0, v_p^0} = cal(C)_0(Delta t, u_(p-1)^0, v_(p-1)^0, diff_t^2 u)$.

Subproblems $P_p$ take the same from as in @IVP, but instead using initial conditions defined by those in the initial root solution.  For example, the subproblem $P_1$ for the second ($p = 1$) subdomain, takes the form

$ P_1 = {cal(L)(t, u, diff_t u, diff_t^2 u) = f(t), #h(11pt)  u(0) = u_1^0,  diff_t u(0) = v_1^0, #h(11pt) [t_0, t_0 + Delta t]}. $

@prep_subproblems shows the steps of this process for a given IVP and integration algorithm i.e. "propagator", resulting in root solutions and and the collected subproblems.  With these subproblems in hand, the PA continues to its next stage: propagating these problems in parallel.

#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [Prepare the subproblems],
  pseudocode-list(
    numbered-title: smallcaps[Prepare the subproblems],
    booktabs: true, 
    hooks: 0.5em
  )[
    - *INPUT:* Second order initial value problem `P`, Coarse solver `C`
    - *OUTPUT:* Solution for `P` made from `pos_seq` and `vel_seq`, and array of subproblems `subproblems`
    - \/\/ _choose discretization_
    + `N` #gets number of subproblems \/\/ _e.g. multiple of \# of computer cores_
    - \/\/ _partition the domain of P into N subdomains e.g. [a, b] -> {[a, c], [c, b]}_
    + `subdomains` #gets `partition(P.domain)`
    - \/\/ _use coarse solver to get positions and velocities for the root problem_
    + `pos_seq`, `vel_seq` #gets `propagate(P, C)`
    - \/\/ _create subproblems_
    + *for* `i` from 1 to `N`
      + `subdomain` #gets `i`-th domain partition `subdomains[i]`
      + `pos0` #gets initial position for `i`-th subproblem `pos_seq[i]`
      + `vel0` #gets initial velocity for `i`-th subproblem `vel_seq[i]`
      + `subproblems[i]` #gets ivp on `subdomain` with initial values `pos0` and `vel0` for acceleration `P.acc`
    + *return* Solution for root problem with `pos_seq` and `vel_seq`, and array of subproblems `subproblems`
  ]
) <prep_subproblems>

=== Parallel Propagation

  Use a coarse propagator $cal(C)$ (e.g., Symplectic-Euler with a large time step) and a fine propagator $cal(F)$ (e.g. Velocity-Verlet with a small time step). Solve each subproblem $p$ in parallel.

=== Corrections

  Compute corrections for the coarse solutions using:
  $ eta_p^i = cal(F) u_p^i (T_(p+1)) - cal(C) u_p^i (T_(p+1)), $

  and apply corrections sequentially:
  $ u_{p+1}^i (T_(p+1)) = u_p^i (T_(p+1)) + eta_p^i. $

=== Iteration & Convergence

  Repeat the process for updated initial values until convergence, e.g.:
  $ |u_p^i - u_p^{i-1}| < epsilon #h(11pt) forall p <= N. $

In addition to parallelizing, part of the magic of the Parareal algorithm lies in solving each subproblem not once, but twice with different solves or _propagators_.  The next step in the process is to choose _coarse_, and _fine_. It should be noted that this coarse propagator does not need to be the same as the coarse propagator that was chosen in preparing the subproblems.  Possible propagators include the semi-implicit Euler method with a large time step for the corase propagator, and the velocity-verlet method with a small time step for the fine propagator; in order to satisfy energy-conservation, symplectic integrators should be used.  Without loss of generality, let the chosen coarse and fine propagators be denoted $cal(C), cal(F)$, respectively, and the $n_cal(S)$-th data point for propagator $cal(S)$ in the $p$-th subprobem at iteration $i$ be denoted $u_(p n_cal(S))^i$ and defined traditionally by $u_(p n_cal(S))^i = cal(S) u_(p n_cal(S) - 1)^i$, and the solution from propagator $cal(S)$ on subproblem $p$ is the ordered collection of points $cal(S) u_p^i = u_(p n_cal(S))^i_(n_cal(S))$.

== The Parareal Algorithm at Scale

- Parallelize on the GPU instead of the CPU
  - Port functionality to kernel calls
    - Technical: Instead of objects with properties, it's just the same index for a bunch of different arrays
    - Vibes: Makes logic less understandable comp
  + From the host, launch the Parareal kernel on the device
    + Each core on the device executes the same sequence of instructions (kernel), but uses different thread-local variables such as their thread id, block id, etc.
    + Use traditional and sequential solvers on each core for each subproblem
    + Write the final point to an array
  + Send solution data back to host for sequential correction
  + Host corrects and loops

- Distribute problems over multiple processes/devices
  - Preparing the Cluster
    - Currently only works for an ssh-cluster i.e. a collection of machines that can all be accessed via ssh from the head node
    - A "remote node" could also be a single process on a single machine, the differences are straightforward
    - Given a head node and a collection of remote nodes
    + Spawn a worker, or "sub-manager", process on each remote node
    + Each sub-manager identifies how many devices are avavilable to the node, and send that information back to the manager process
    + The manager process spawns a worker process on the appropriate node for each device on that node
    + Each process aquires a device
  + For each problem:
    + Send it to a process
    + Execute the parareal algorithm on that problem using the assigned device
    + Send the result to the manager process to be used in corrections

#figure(
  image("images/cluster_topology.png"),
  caption: [A representative cluster topology.]
)

=== The Parareal Algorithm on the GPU

- Execute the parallel propagation on the GPU
  - Requires transforming "regular code" into a "kernel" that's evaluated on every computer core
  - Make solution data an array that is copied to the device which can then just write to the appropriate index
  - Use thread-local variables (e.g. `threadidx.x`, `blockIdx.x`, etc.) to identify the appropriate index
  - "Don't overwrite your neighbor" by index striding.

#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [GPU kernel to calculate the discretized points in a subdomain in-place],
  pseudocode-list(
    numbered-title: smallcaps[discretize_kernel],
    booktabs: true, 
    hooks: 0.5em
  )[
    - *INPUT:* Sequence of points in the subdomain `dompnts`
    - *OUTPUT:* Nothing
    + `npnts`   #gets number of points in `dompnts`
    + `lb`      #gets lower bound of this subdomain `dompnts[1]`
    + `ub`      #gets upper bound of this subdomain `dompnts[-1]`
    + `step`    #gets (`ub` - `lb`) / `npnts`
    + *for* `i` from 2 to (`npnts` - 1)
      + `dompnts[i]` #gets `lb` + (`i` - 1) \* `step`
  ]
)

#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [GPU kernel to propagate solutions in-place],
  pseudocode-list(
    numbered-title: smallcaps[propagate_kernel],
    booktabs: true, 
    hooks: 0.5em
  )[
    - *INPUT:* Solver function `sol`, Acceleration function `acc`, Domain points `dompnts`, Position sequence `pos_seq`, Velocity sequence `vel_seq`
    - *OUTPUT:* Nothing
    + `npnts` #gets number of points in domain `dompnts`
    + *for* `i` from 2 to (`npnts` - 1)
      + `op` #gets old position `pos_seq[i - 1]`
      + `ov` #gets old velocity `vel_seq[i - 1]`
      + `np` #gets new position `pos_seq[i]`
      + `nv` #gets new velocity `vel_seq[i]`
      + `np`, `nv` #gets `solver`(`op`, `ov`, `acc`, `step`) // FIXME: find call to step
  ]
)

#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  caption: [Main kernel],
  pseudocode-list(
    numbered-title: smallcaps[kernel],
    booktabs: true, 
    hooks: 0.5em
  )[
    - *INPUT:* Solver function `sol`, Acceleration function `acc`, Sequence of sequenes of domain points `dss`, Sequence of sequences of positions `pss`, Sequence of sequences of velocities `vss`
    - *OUTPUT:* Nothing

    + `nsols`   #gets number of subproblems or subdomains

    - \/\/      INDEX STRIDING // make gray to more directly show it's a comment
    + `index`  #gets (block_id - 1) \* block_dim + thread_id
    + `stride` #gets grid_dim \* block_dim
    + *for* `i` from `index` to `nsols` in steps of `stride`

      - \/\/    DISCRETIZE DOMAINS
      + `dompnts` #gets sequence of points in this subdomain `dss[i]`
      + `discretize_kernel`(`dompnts`)

      - \/\/      ALLOCATE SOLUTIONS
      + `pos_seq` #gets sequence of positions for this subproblem `pss[i]`
      + `vel_seq` #gets sequence of velocities for this subproblem `vss[i]`
      + `propagate_kernel`(`sol`, `acc`, `dompnts`, `pos_seq`, `vel_seq`)
  ]
)

#figure(
  image("images/parallel_propagation_gpu.png", width: 100%),
  caption: [Sequential solutions (blue) are sent to the GPU to be finely-propagated (red) in parallel; true solutions (black) are shown for comparison.]
)

=== The Parareal Algorithm on Multiple GPUs

- How did I glue GPU and Distributed computing together with the Parareal algorithm to make it scalable?
  - GPU Computing: solve each subproblem on a each gpu core
    - make stuff into arrays
    - thread indexing blocks streaming multiprocessors
  - Distributed Computing: solve each root problem on each node
    - "Just add another machine"
    - Automatically determine number of devices on each node
    - Sharing data across processes

#pagebreak()
= Discussion

== Numerical Analysis

- use the pendulum i.e. the simple harmonic oscillator to test numerical analysis properties since we know the analytic solutions and can compare.

=== Convergence

=== Stability

=== Error

== Algorithm Analysis

=== Time Complexity

=== Space Complexity

== Benchmarks

= Conclusion
- Equations of motion can now benefit from parallel solvers.
- Certain problems are well-suited to a divide-and-conquer approach.
- Problems with "doubly parallel" characteristics can leverage both local and distributed parallelism, achieving significant computational efficiency.
- These advancements pave the way for modeling acoustics in expanding volumes.

== Future work
- Krylov enhanced subspaces
- CUDA dynamic parallelism
- Implement with C, Fortran, CUDA, NVSHMEM, MPI
- Make gpu-backend-agnostic with KernelAbstractions.jl
- this physics could be better done with PFASST

#pagebreak()
#bibliography(
  "bib.bib",
  full: true,
  style: "american-physics-society"
)