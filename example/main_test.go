package main

import (
	"testing"

	"github.com/stretchr/testify/require"
)

func TestEcho(t *testing.T) {
	err := echo([]string{"hello,", "world"})
	require.NoError(t, err)
}

func TestEchoNoArgs(t *testing.T) {
	err := echo([]string{})
	require.Error(t, err)
}
