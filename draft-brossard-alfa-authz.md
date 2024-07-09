---
title: "ALFA 2.0 - the Abbreviated Language for Authorization"
abbrev: "alfa-authz"
category: std
ipr: trust200902

docname: draft-brossard-alfa-authz-latest
submissiontype: IETF
number:
date:
consensus: true
v: 3
area: "Security"
workgroup: "Web Authorization Protocol"
keyword:
 - authorization
 - abac
 - rebac
 - rbac
 - access control
 - xacml
 - policy language
venue:
  group: "Web Authorization Protocol"
  type: "Working Group"
  mail: "oauth@ietf.org"
  arch: "https://mailarchive.ietf.org/arch/browse/oauth/"
  github: "davidjbrossard/alfa-authorization-language"
  latest: "https://davidjbrossard.github.io/alfa-authorization-language/draft-brossard-alfa-authz.html"

author:
 -
    fullname: David Brossard
    organization: Axiomatics
    email: david.brossard@gmail.com
    country: Canada
 -
    fullname: Andrew Clymer
    organization: Rock Solid Knowledge
    email: andy@rocksolidknowledge.com
    country: United Kingdom
 -
    fullname: Theodosios Dimitrakos
    organization: University of Kent School of Computing
    email: t.dimitrakos@kent.ac.uk

normative:
  XACML:
    target: https://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html
    title: eXtensible Access Control Markup Language (XACML) Version 3.0, OASIS Standard
    date: January 2013
    author:
    -
      name: Erik Rissanen
      ins: E. Rissanen
      org: Axiomatics AB
  ABAC:
    target: https://doi.org/10.6028/NIST.SP.800-162
    title: Guide to Attribute Based Access Control (ABAC) Definition and Considerations - NIST Special Publication 800-162
    date: January 2014
    author:
    -
      name: Vincent Hu
      ins: V. Hu
      org: NIST
    -
      name: David Ferraiolo
      ins: D. Ferraiolo
      org: NIST
  ALFA:
    target: https://groups.oasis-open.org/higherlogic/ws/public/download/55228/alfa-for-xacml-v1.0-wd01.doc
    title: Abbreviated Language for Authorization Version 1.0
    date: 10 March 2015
    author:
    -
      name: Pablo Giambiagi
      org: Axiomatics
    -
      name: Srijith K. Nair
      org: Axiomatics
    -
      name: David Brossard
      org: Axiomatics


informative:
  OAUTH: RFC6749
  RBAC:
    target: https://doi.org/10.1145/344287.344301
    title: "The NIST Model for Role-Based Access Control: Towards a Unified Standard"
    date: July 26, 2000
    author:
    -
      name: D. Richard Kuhn
      ins: R. Kuhn
      org: NIST
    -
      name: David Ferraiolo
      ins: D. Ferraiolo
      org: NIST
    -
      name: R. Sandhu
      ins: R. Sandhu
      org: NIST
  ReBAC:
    target: https://doi.org/10.1145/344287.344301
    title: "Access Control Requirements for Web 2.0 Security and Privacy"
    date: January 2007
    author:
    -
      name: Carrie Gates
      ins: C. Gates
      org: CA Technologies
  OPA:
    target: https://www.openpolicyagent.org/docs/latest/
    title: Open Policy Agent | Documentation
    date: July 2024
    author:
    -
      name: Styra
      org: Styra

--- abstract

The Abbreviated Language for Authorization 2.0 is a constrained policy language aimed at solving fine-grained
authorization challenges. This specification builds on top of [XACML] and replaces [ALFA] to provide a more complete
and easier language to use.

Use cases for ALFA 2.0 include the ability to express:
- Role-based access control ([RBAC]),
- Attribute-based access control ([ABAC]), and
- Relationship-based access control ([ReBAC])


--- middle

# Introduction

While authentication has _largely_ been solved and standardized (see [OAUTH] and SAML as successful authentication standards), not as much can be said of authorization. One of the oldest and more mature standards is [XACML], the eXtensible Access Control Markup Language established in 2001 under the helm of OASIS. The latest version, XACML 3.0, was released in 2013.

Since, there has been little innovation in the authorization space. Two standards emerged:

- ALFA: Abbreviated Language for Authorization (ALFA) is a domain-specific language for a high-level description of XACML policies. It is designed with ease of use in mind, for use by XACML policy writers. ALFA provides the means to present domain specific information, such as attribute identifiers, in compact form and lays down the basic principle to compile policies expressed in ALFA into XACML 3.0 policies. ALFA does not bring new semantics to XACML. Anything that can be expressed in ALFA must be expressible in XACML. ALFA has been designed in such a way that lossless round-trip translations is possible.
- OPA: Open Policy Agent is an open source, general-purpose policy engine that unifies policy enforcement across the stack. OPA provides a high-level declarative language that lets you specify policy as code and simple APIs to offload policy decision-making from your software. [OPA]

While OPA became part of CNCF, ALFA remained as a draft under OASIS. OPA's strength is also its drawback. It's a fullblown Datalog-based programming language which can achieve anything: it's extremely broad. As for ALFA, as mentioned above, it's true to XACML and aims to achieve lossless round-trip translations leading to unnecessary complications in ALFA's existing grammar.

The aim of this standard is to provide a simple and constrained authorization language largely inspired by ALFA but not tied to XACML and not limited by the need to provide round-tripping.


# Conventions and Definitions

{::boilerplate bcp14-tagged}


# Security Considerations

TODO Security


# IANA Considerations

This document has no IANA actions.


--- back

# Acknowledgments
{:numbered="false"}

The authors would like to acknowledge the authors of the original version of ALFA namely Pablo Giambiagi and Dr. Srijith Nair. The authors would also like to acknowledge Erik Rissanen, the then editor of the XACML Technical Committee.
