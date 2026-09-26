.PHONY: test check release

test:
	moon test --target all

check:
	moon check
	moon fmt
	git diff --exit-code

# Usage: make release v=0.2.0
release:
	@test -n "$(v)" || (echo "Usage: make release v=0.2.0" && exit 1)
	@moon test --target all
	sed -i '' 's/^version = "[^"]*"/version = "$(v)"/' moon.mod
	git add moon.mod
	git commit -m "release: v$(v)"
	git push
	gh release create "v$(v)" --generate-notes
