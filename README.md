# statuspixel

**`[WIP]`**

display color-coded status of stuff with LED pixels.

## JSON Configuration

See the [example below](#example) and consult this description if questions arise.

- **`colors`**: Object. Keys are names of colors to be used in rest of config, values are valid `CSS` color strings (names, hex, hsl, …).
- **`sections`**: Array of Objects with keys:
    - `id`: unique short name of section (word-characters allowed)
    - `description`: optional description of the section
    - `start`: the first pixel which belongs to the section, it will go to the end or one pixel before the next section
    - one of:
        - `command`: run a shell command
        - `request`: make a HTTP request
    - `expect`: hash of expectations on (at least one of) the following values (see below for possible expectations):
        - `status`: exit status of `command`, or http status of `request`
        - `output`: `stdout` of `command`, or `res` of `request`
        - `error`: `stderr` of `command`, or `err` of `request`
    
- `ok`: if `assert` was true, set section to this color
- `fail`: if `assert` was false, set section to this color

Expectations: can be in one of the following forms
- simple value (number, string): must be exactly equal to compared value
- hash of "comparators" from [the `ruler` module][`ruler`] and the value to compare.

automatic assertions (no need to add those):
- `{ "status": { truthy: "" } }`
- `{ "err": { falsy: "" } }`

### Example 

```json
{
  "colors": {
    "green": "green",
    "red": "red",
    "white": "#ccc"
  },
  "sections": [
    {
      "id": "ping_npm",
      "description": "ping npmjs.com",
      "start": 0,
      "command": "ping -W 1 -c 1 npmjs.com",
      "expect": {
        "status": 0
      },
      "ok": "green",
      "fail": "red"
    },
    {
      "id": "get_npm",
      "description": "HTTP GET npmjs.com",
      "start": 30,
      "request": "http://npmjs.com",
      "expect": {
        "status": {
          "gte": 200,
          "lt": 300
        },
        "output": {
          "contains": "package manager"
        }
      },
      "ok": "green",
      "fail": "red"
    }
  ]
}
```


[`must`]: <https://github.com/moll/js-must/blob/master/doc/API.md>
[`ruler`]: <https://www.npmjs.com/package/ruler>
