// Code generated by depstubber. DO NOT EDIT.
// This is a simple stub for go-micro.dev/v4, strictly for use in testing.

// See the LICENSE file for information about the licensing of the original library.
// Source: go-micro.dev/v4 (exports: Service; functions: )

// Package go_pkg is a stub of go-micro.dev/v4, generated by depstubber.
package go_pkg

import (
	context "context"
)

type Option func(*Options)

type Options struct {
	Registry    interface{}
	Store       interface{}
	Auth        interface{}
	Cmd         interface{}
	Config      interface{}
	Client      interface{}
	Server      interface{}
	Context     context.Context
	Cache       interface{}
	Runtime     interface{}
	Profile     interface{}
	Transport   interface{}
	Logger      interface{}
	Broker      interface{}
	BeforeStart []func() error
	AfterStart  []func() error
	AfterStop   []func() error
	BeforeStop  []func() error
	Signal      bool
}

type Service interface {
	Client() interface{}
	Init(_ ...Option)
	Name() string
	Options() Options
	Run() error
	Server() interface{}
	String() string
}
