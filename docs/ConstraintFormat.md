### Constraint Type
| 0. Type | 1. Operand A | 2. Operand B | Expression    |
|      ---|           ---|           ---|            ---|
| 0       | A            |              | A ∈ [[A]]    |
| 1       | A            | B            | A ∈ [[B]]    |
| 2       | A            | B            | A ⊆ [[B]]    |
| 3       | A            | B            | ∀a ∈ [[A] ⟶ <br> [[a]] ⊆ [[B]] |
| 4       | A            | B            | ∀a ∈ [[A]] ⟶ <br> [[B]] ⊆ [[a]] |

#### Example

```json
    "Constraints":[
		[0, "A"],
		[0, "B"],
		[0, "C"],
		[1, "A", "B"]
	]
```