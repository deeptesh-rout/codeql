// Code generated by depstubber. DO NOT EDIT.
// This is a simple stub for github.com/spf13/afero, strictly for use in testing.

// See the LICENSE file for information about the licensing of the original library.
// Source: github.com/spf13/afero (exports: Afero,RegexpFs,HttpFs,ReadOnlyFs,MemMapFs,OsFs,BasePathFs; functions: WriteReader,SafeWriteReader,WriteFile,ReadFile,ReadDir)

// Package afero is a stub of github.com/spf13/afero, generated by depstubber.
package afero

import (
	io "io"
	fs "io/fs"
	http "net/http"
	filepath "path/filepath"
	time "time"
)

type Afero struct {
	Fs Fs
}

func (_ Afero) Chmod(_ string, _ fs.FileMode) error {
	return nil
}

func (_ Afero) Chown(_ string, _ int, _ int) error {
	return nil
}

func (_ Afero) Chtimes(_ string, _ time.Time, _ time.Time) error {
	return nil
}

func (_ Afero) Create(_ string) (File, error) {
	return nil, nil
}

func (_ Afero) DirExists(_ string) (bool, error) {
	return false, nil
}

func (_ Afero) Exists(_ string) (bool, error) {
	return false, nil
}

func (_ Afero) FileContainsAnyBytes(_ string, _ [][]byte) (bool, error) {
	return false, nil
}

func (_ Afero) FileContainsBytes(_ string, _ []byte) (bool, error) {
	return false, nil
}

func (_ Afero) GetTempDir(_ string) string {
	return ""
}

func (_ Afero) IsDir(_ string) (bool, error) {
	return false, nil
}

func (_ Afero) IsEmpty(_ string) (bool, error) {
	return false, nil
}

func (_ Afero) Mkdir(_ string, _ fs.FileMode) error {
	return nil
}

func (_ Afero) MkdirAll(_ string, _ fs.FileMode) error {
	return nil
}

func (_ Afero) Name() string {
	return ""
}

func (_ Afero) Open(_ string) (File, error) {
	return nil, nil
}

func (_ Afero) OpenFile(_ string, _ int, _ fs.FileMode) (File, error) {
	return nil, nil
}

func (_ Afero) ReadDir(_ string) ([]fs.FileInfo, error) {
	return nil, nil
}

func (_ Afero) ReadFile(_ string) ([]byte, error) {
	return nil, nil
}

func (_ Afero) Remove(_ string) error {
	return nil
}

func (_ Afero) RemoveAll(_ string) error {
	return nil
}

func (_ Afero) Rename(_ string, _ string) error {
	return nil
}

func (_ Afero) SafeWriteReader(_ string, _ io.Reader) error {
	return nil
}

func (_ Afero) Stat(_ string) (fs.FileInfo, error) {
	return nil, nil
}

func (_ Afero) TempDir(_ string, _ string) (string, error) {
	return "", nil
}

func (_ Afero) TempFile(_ string, _ string) (File, error) {
	return nil, nil
}

func (_ Afero) Walk(_ string, _ filepath.WalkFunc) error {
	return nil
}

func (_ Afero) WriteFile(_ string, _ []byte, _ fs.FileMode) error {
	return nil
}

func (_ Afero) WriteReader(_ string, _ io.Reader) error {
	return nil
}

type BasePathFs struct{}

func (_ *BasePathFs) Chmod(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *BasePathFs) Chown(_ string, _ int, _ int) error {
	return nil
}

func (_ *BasePathFs) Chtimes(_ string, _ time.Time, _ time.Time) error {
	return nil
}

func (_ *BasePathFs) Create(_ string) (File, error) {
	return nil, nil
}

func (_ *BasePathFs) LstatIfPossible(_ string) (fs.FileInfo, bool, error) {
	return nil, false, nil
}

func (_ *BasePathFs) Mkdir(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *BasePathFs) MkdirAll(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *BasePathFs) Name() string {
	return ""
}

func (_ *BasePathFs) Open(_ string) (File, error) {
	return nil, nil
}

func (_ *BasePathFs) OpenFile(_ string, _ int, _ fs.FileMode) (File, error) {
	return nil, nil
}

func (_ *BasePathFs) ReadlinkIfPossible(_ string) (string, error) {
	return "", nil
}

func (_ *BasePathFs) RealPath(_ string) (string, error) {
	return "", nil
}

func (_ *BasePathFs) Remove(_ string) error {
	return nil
}

func (_ *BasePathFs) RemoveAll(_ string) error {
	return nil
}

func (_ *BasePathFs) Rename(_ string, _ string) error {
	return nil
}

func (_ *BasePathFs) Stat(_ string) (fs.FileInfo, error) {
	return nil, nil
}

func (_ *BasePathFs) SymlinkIfPossible(_ string, _ string) error {
	return nil
}

type File interface {
	Close() error
	Name() string
	Read(_ []byte) (int, error)
	ReadAt(_ []byte, _ int64) (int, error)
	Readdir(_ int) ([]fs.FileInfo, error)
	Readdirnames(_ int) ([]string, error)
	Seek(_ int64, _ int) (int64, error)
	Stat() (fs.FileInfo, error)
	Sync() error
	Truncate(_ int64) error
	Write(_ []byte) (int, error)
	WriteAt(_ []byte, _ int64) (int, error)
	WriteString(_ string) (int, error)
}

type Fs interface {
	Chmod(_ string, _ fs.FileMode) error
	Chown(_ string, _ int, _ int) error
	Chtimes(_ string, _ time.Time, _ time.Time) error
	Create(_ string) (File, error)
	Mkdir(_ string, _ fs.FileMode) error
	MkdirAll(_ string, _ fs.FileMode) error
	Name() string
	Open(_ string) (File, error)
	OpenFile(_ string, _ int, _ fs.FileMode) (File, error)
	Remove(_ string) error
	RemoveAll(_ string) error
	Rename(_ string, _ string) error
	Stat(_ string) (fs.FileInfo, error)
}

type HttpFs struct{}

func (_ HttpFs) Chmod(_ string, _ fs.FileMode) error {
	return nil
}

func (_ HttpFs) Chown(_ string, _ int, _ int) error {
	return nil
}

func (_ HttpFs) Chtimes(_ string, _ time.Time, _ time.Time) error {
	return nil
}

func (_ HttpFs) Create(_ string) (File, error) {
	return nil, nil
}

func (_ HttpFs) Dir(_ string) interface{} {
	return nil
}

func (_ HttpFs) Mkdir(_ string, _ fs.FileMode) error {
	return nil
}

func (_ HttpFs) MkdirAll(_ string, _ fs.FileMode) error {
	return nil
}

func (_ HttpFs) Name() string {
	return ""
}

func (_ HttpFs) Open(_ string) (http.File, error) {
	return nil, nil
}

func (_ HttpFs) OpenFile(_ string, _ int, _ fs.FileMode) (File, error) {
	return nil, nil
}

func (_ HttpFs) Remove(_ string) error {
	return nil
}

func (_ HttpFs) RemoveAll(_ string) error {
	return nil
}

func (_ HttpFs) Rename(_ string, _ string) error {
	return nil
}

func (_ HttpFs) Stat(_ string) (fs.FileInfo, error) {
	return nil, nil
}

type MemMapFs struct{}

func (_ *MemMapFs) Chmod(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *MemMapFs) Chown(_ string, _ int, _ int) error {
	return nil
}

func (_ *MemMapFs) Chtimes(_ string, _ time.Time, _ time.Time) error {
	return nil
}

func (_ *MemMapFs) Create(_ string) (File, error) {
	return nil, nil
}

func (_ *MemMapFs) List() {}

func (_ *MemMapFs) LstatIfPossible(_ string) (fs.FileInfo, bool, error) {
	return nil, false, nil
}

func (_ *MemMapFs) Mkdir(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *MemMapFs) MkdirAll(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *MemMapFs) Name() string {
	return ""
}

func (_ *MemMapFs) Open(_ string) (File, error) {
	return nil, nil
}

func (_ *MemMapFs) OpenFile(_ string, _ int, _ fs.FileMode) (File, error) {
	return nil, nil
}

func (_ *MemMapFs) Remove(_ string) error {
	return nil
}

func (_ *MemMapFs) RemoveAll(_ string) error {
	return nil
}

func (_ *MemMapFs) Rename(_ string, _ string) error {
	return nil
}

func (_ *MemMapFs) Stat(_ string) (fs.FileInfo, error) {
	return nil, nil
}

type OsFs struct{}

func (_ OsFs) Chmod(_ string, _ fs.FileMode) error {
	return nil
}

func (_ OsFs) Chown(_ string, _ int, _ int) error {
	return nil
}

func (_ OsFs) Chtimes(_ string, _ time.Time, _ time.Time) error {
	return nil
}

func (_ OsFs) Create(_ string) (File, error) {
	return nil, nil
}

func (_ OsFs) LstatIfPossible(_ string) (fs.FileInfo, bool, error) {
	return nil, false, nil
}

func (_ OsFs) Mkdir(_ string, _ fs.FileMode) error {
	return nil
}

func (_ OsFs) MkdirAll(_ string, _ fs.FileMode) error {
	return nil
}

func (_ OsFs) Name() string {
	return ""
}

func (_ OsFs) Open(_ string) (File, error) {
	return nil, nil
}

func (_ OsFs) OpenFile(_ string, _ int, _ fs.FileMode) (File, error) {
	return nil, nil
}

func (_ OsFs) ReadlinkIfPossible(_ string) (string, error) {
	return "", nil
}

func (_ OsFs) Remove(_ string) error {
	return nil
}

func (_ OsFs) RemoveAll(_ string) error {
	return nil
}

func (_ OsFs) Rename(_ string, _ string) error {
	return nil
}

func (_ OsFs) Stat(_ string) (fs.FileInfo, error) {
	return nil, nil
}

func (_ OsFs) SymlinkIfPossible(_ string, _ string) error {
	return nil
}

func ReadDir(_ Fs, _ string) ([]fs.FileInfo, error) {
	return nil, nil
}

func ReadFile(_ Fs, _ string) ([]byte, error) {
	return nil, nil
}

type ReadOnlyFs struct{}

func (_ *ReadOnlyFs) Chmod(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *ReadOnlyFs) Chown(_ string, _ int, _ int) error {
	return nil
}

func (_ *ReadOnlyFs) Chtimes(_ string, _ time.Time, _ time.Time) error {
	return nil
}

func (_ *ReadOnlyFs) Create(_ string) (File, error) {
	return nil, nil
}

func (_ *ReadOnlyFs) LstatIfPossible(_ string) (fs.FileInfo, bool, error) {
	return nil, false, nil
}

func (_ *ReadOnlyFs) Mkdir(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *ReadOnlyFs) MkdirAll(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *ReadOnlyFs) Name() string {
	return ""
}

func (_ *ReadOnlyFs) Open(_ string) (File, error) {
	return nil, nil
}

func (_ *ReadOnlyFs) OpenFile(_ string, _ int, _ fs.FileMode) (File, error) {
	return nil, nil
}

func (_ *ReadOnlyFs) ReadDir(_ string) ([]fs.FileInfo, error) {
	return nil, nil
}

func (_ *ReadOnlyFs) ReadlinkIfPossible(_ string) (string, error) {
	return "", nil
}

func (_ *ReadOnlyFs) Remove(_ string) error {
	return nil
}

func (_ *ReadOnlyFs) RemoveAll(_ string) error {
	return nil
}

func (_ *ReadOnlyFs) Rename(_ string, _ string) error {
	return nil
}

func (_ *ReadOnlyFs) Stat(_ string) (fs.FileInfo, error) {
	return nil, nil
}

func (_ *ReadOnlyFs) SymlinkIfPossible(_ string, _ string) error {
	return nil
}

type RegexpFs struct{}

func (_ *RegexpFs) Chmod(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *RegexpFs) Chown(_ string, _ int, _ int) error {
	return nil
}

func (_ *RegexpFs) Chtimes(_ string, _ time.Time, _ time.Time) error {
	return nil
}

func (_ *RegexpFs) Create(_ string) (File, error) {
	return nil, nil
}

func (_ *RegexpFs) Mkdir(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *RegexpFs) MkdirAll(_ string, _ fs.FileMode) error {
	return nil
}

func (_ *RegexpFs) Name() string {
	return ""
}

func (_ *RegexpFs) Open(_ string) (File, error) {
	return nil, nil
}

func (_ *RegexpFs) OpenFile(_ string, _ int, _ fs.FileMode) (File, error) {
	return nil, nil
}

func (_ *RegexpFs) Remove(_ string) error {
	return nil
}

func (_ *RegexpFs) RemoveAll(_ string) error {
	return nil
}

func (_ *RegexpFs) Rename(_ string, _ string) error {
	return nil
}

func (_ *RegexpFs) Stat(_ string) (fs.FileInfo, error) {
	return nil, nil
}

func SafeWriteReader(_ Fs, _ string, _ io.Reader) error {
	return nil
}

func WriteFile(_ Fs, _ string, _ []byte, _ fs.FileMode) error {
	return nil
}

func WriteReader(_ Fs, _ string, _ io.Reader) error {
	return nil
}
