---
###
# Internet-Draft Markdown Template
#
# Rename this file from draft-todo-yourname-protocol.md to get started.
# Draft name format is "draft-<yourname>-<workgroup>-<name>.md".
#
# For initial setup, you only need to edit the first block of fields.
# Only "title" needs to be changed; delete "abbrev" if your title is short.
# Any other content can be edited, but be careful not to introduce errors.
# Some fields will be set automatically during setup if they are unchanged.
#
# Don't include "-00" or "-latest" in the filename.
# Labels in the form draft-<yourname>-<workgroup>-<name>-latest are used by
# the tools to refer to the current version; see "docname" for example.
#
# This template uses kramdown-rfc: https://github.com/cabo/kramdown-rfc
# You can replace the entire file if you prefer a different format.
# Change the file extension to match the format (.xml for XML, etc...)
#
###
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

informative:
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

TODO Introduction


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
