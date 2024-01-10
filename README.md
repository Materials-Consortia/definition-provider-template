# definition-provider-template

Template repository for definition providers.

1. Clone this repo (with submodules for tools)
   ```
   git clone --recurse-submodules https://github.com/Materials-Consortia/definition-provider-template.git
   ```

2. Modify schemas in `src/`.

3. Run make.

4. Output appears in `output/`, check the standards document with, e.g.:
   ```
   firefox output/v0.1.0/standards/smell
   ```

Notes:

- For prettifed HTML output add `schemas_html_pretty=true` when running make:
  ```
  make schemas_html_pretty=true
  ```

- To generate HTML output with `.html` extensions (instead of extensionless):
  ```
  make schemas_html_ext=true
  ```
  (Less suited for filesystem browsing, but works as intended when served e.g. via GitHub pages)
