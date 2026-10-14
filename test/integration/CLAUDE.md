# integration

## What it is

Tests that build several real features through the composition root, feed a scripted sequence of `PlayerCommand`s over a fixed number of steps with a fixed seed, and assert the events and snapshots that cross the contracts.

## Roots

`test/integration/`

## Not here

- A test of one feature alone: `test/features/<feature>/`.
- Mocks of anything but the edges of the machine — files, audio, the clock.
