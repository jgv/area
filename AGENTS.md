# Area Gem Instructions

This Ruby gem maps phone, ZIP, location, coordinate, and time-zone data through `lib/` and bundled data, with unit tests in `test/unit/`. Install dependencies with `bundle install`, then run `bundle exec rake`, which invokes the Rake `test` task over those unit files.

Keep normalization and return-value behavior compatible, and add a focused unit test for a geographic edge case. Completion is the affected unit test plus the Rake task when the legacy dependency set runs. Do not replace bundled public data from an unverified source or introduce a runtime network dependency.
