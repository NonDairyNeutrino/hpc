#import "@preview/charged-ieee:0.1.3": ieee
#import "@preview/physica:0.9.5": *

#show: ieee.with(
  title: [Are Supercomputers Obsolete? \ Quantum & High-Performance Computing],
  // abstract: [
  //   The process of scientific writing is often tangled up with the intricacies of typesetting, leading to frustration and wasted time for researchers. In this paper, we introduce Typst, a new typesetting system designed specifically for scientific writing. Typst untangles the typesetting process, allowing researchers to compose papers faster. In a series of experiments we demonstrate that Typst offers several advantages, including faster document creation, simplified syntax, and increased ease-of-use.
  // ],
  authors: (
    (
      name: "Nathan Chapman",
      department: [Department of Computer Science],
      organization: [Central Washington University],
      location: [Ellensburg, Washington],
      email: "nathaniel.chapman@cwu.edu"
    ),
  ),
  index-terms: ("Quantum Computing", "High-Performance Computing"),
  bibliography: bibliography("bib.bib")
)

= Introduction

  == Information

  == Classical Computation

    === Bits

  == Quantum Computation

    === Quantum Bits (Qubits)

-  The bit and qubit is the most fundamental concept of information
-  A classical bit has a state: either 0 or 1
-  A quantum bit   has a state: $ket(0), ket(1), alpha ket(0) + beta ket(1)$ for complex $alpha, beta$ such that $|alpha|^2 + |beta|^2 = 1$
-  The state of a qubit is a unit vector in a two-dimensional complex vector space.  In other words, qubits similar to are unit quarternions.
-  $ket(0), ket(1)$ are orthonormal and form computational basis states
-  Can't directly measure $alpha, beta$
-  Example: a ``quantum coin'' with state $ket{+} = 1 / sqrt(2) ket(0) + 1 / sqrt(2) ket(1)$ and 50-50 probability
-  Can write $ket(psi) = e^(i gamma) cos  theta / 2  ket(0) + e^(i phi) sin  theta / 2  ket(0) $
-  Because $e^(i gamma)$ has no observable effect, we can reduced the above to $ket(psi) = cos  theta / 2  ket(0) + e^(i phi) sin  theta / 2  ket(0)$
-  While a qubit can only measure to be 0 or 1, until measurement there is ``hidden information'' encoded in $alpha$ and $beta$.

  == High-Performance Computing

= Methods

  == Quantum Gates

    === Single Qubit Gates

    === Multiple Qubit Gates

  == Quantum Circuits

  == Quantum Algorithms

    === The Quantum Fourier Transform

    === The Quantum Search Algorithm

= Discussion

  == Post-Quantum Cryptography

= Conclusion
