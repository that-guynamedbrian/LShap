local ls_types = require(script.Parent["ls-types"])
return {
    namespaces = {} :: {[string]: ls_types.namespace};
    defining_namespace = {} :: ls_types.namespace;
    defining_class = {} :: ls_types.class;
    environments = {} :: {[thread]: ls_types.namespace};
}