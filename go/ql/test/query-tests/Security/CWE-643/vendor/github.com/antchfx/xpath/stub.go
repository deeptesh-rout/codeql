// Code generated by depstubber. DO NOT EDIT.
// This is a simple stub for github.com/antchfx/xpath, strictly for use in testing.

// See the LICENSE file for information about the licensing of the original library.
// Source: github.com/antchfx/xpath (exports: ; functions: Compile,MustCompile,Select)

// Package xpath is a stub of github.com/antchfx/xpath, generated by depstubber.
package xpath

import ()

func Compile(_ string) (*Expr, error) {
	return nil, nil
}

type Expr struct{}

func (_ *Expr) Evaluate(_ NodeNavigator) interface{} {
	return nil
}

func (_ *Expr) Select(_ NodeNavigator) *NodeIterator {
	return nil
}

func (_ *Expr) String() string {
	return ""
}

func MustCompile(_ string) *Expr {
	return nil
}

type NodeIterator struct{}

func (_ *NodeIterator) Current() NodeNavigator {
	return nil
}

func (_ *NodeIterator) MoveNext() bool {
	return false
}

type NodeNavigator interface {
	Copy() NodeNavigator
	LocalName() string
	MoveTo(_ NodeNavigator) bool
	MoveToChild() bool
	MoveToFirst() bool
	MoveToNext() bool
	MoveToNextAttribute() bool
	MoveToParent() bool
	MoveToPrevious() bool
	MoveToRoot()
	NodeType() NodeType
	Prefix() string
	Value() string
}

type NodeType int

func Select(_ NodeNavigator, _ string) *NodeIterator {
	return nil
}
