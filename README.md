# definition-provider-template

Template repository for definition providers.

1. Clone this repo (with submodules for tools)
   ```
   git clone --recurse-submodules https://github.com/Materials-Consortia/definition-provider-template.git
   ```
   Or, if you have already cloned this repo without the submodules, init them with:
   ```
   git submodule update --init --recursive
   ```

2. Set up and activate a virtual environment for the optimade-property-tools dependencies:

   ```
   python3 -m venv venv
   venv/bin/pip3 install -r dependencies/submodules/optimade-property-tools/requirements.txt
   source venv/bin/activate
   ```

3. Modify schemas in `src/`.

4. Run make.

5. Output appears in `output/`, check the standards document with, e.g.:
   ```
   firefox output/v0.1.0/standards/smell
   ```

Notes:

- For prettified HTML output add `schemas_html_pretty=true` when running make:
  ```
  make schemas_html_pretty=true
  ```

- To generate HTML output with `.html` extensions (instead of extensionless):
  ```
  make schemas_html_ext=true
  ```
  (Less suited for filesystem browsing, but works as intended when served e.g. via GitHub pages)
