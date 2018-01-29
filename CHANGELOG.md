v0.3.1 -- 2018-01-29
--------------------

  - Fix bug in `have_form_field` matcher to properly identify
    multi-valued select fields . 3876286

v0.3.0 -- 2017-11-24
--------------------

  - Add ActorCreate build strategy for `FactoryBot`. af4369c

v0.2.0 -- 2017-11-21
--------------------

 - Introduce shared examples for Hyrax metadata
   - 'a model with hyrax core metadata'
   - 'a model with hyrax basic metadata'
 - Add `acts` matcher for testing `Hyrax::Actors` c56248d
 - Bugfix for `have_editable_property` failure reporting. 3a5af61

v0.1.0 -- 2017-11-07
--------------------

 - Initial Release
 - Add initial Hyrax matchers
    - `have_editable_property`
    - `have_form_field`
    - `list_index_fields`
