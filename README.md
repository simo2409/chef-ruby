ruby Cookbook
=============
This cookbook installs ruby 2.1.6 from source.

Ruby will be installed system-wide (no RVM or similar).

Requirements
------------
None

Attributes
----------
```json
{
  "ruby": {
    "lib_yaml": "..",
    "version": ".."
  }
}
```

#### ruby::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['ruby']['lib_yaml']</tt></td>
    <td>String</td>
    <td>libyaml version to use to compile ruby</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['ruby']['version']</tt></td>
    <td>String</td>
    <td>ruby version to install</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### ruby::default
Just include `ruby` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ruby]"
  ]
}
```

Contributing
------------
Need help for testing following best practises, if you can help you are welcome!

License and Authors
-------------------
License: MIT

Authors:

Simone Dall'Angelo
