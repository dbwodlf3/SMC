```python
import sys
sys.path.append("/path/to/anvill/python")
import anvill

# then if that works, try this
# (and you may encounter spurious errors if IDA cannot guess the types of things, so really, this works best with symbolized binaries)

p = anvill.get_program(cache=False)
p.add_function_definition(here())

open("/tmp/spec.json", "w").write(p.proto())
```