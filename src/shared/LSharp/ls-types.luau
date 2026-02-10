export type namespace = {
    __type: "namespace";
    name: string;
    classes: {[string]:class};
}

export type class = {
    __type: "class";
    hooks: {};
    mutables: {[string]:field<nil>};
    immutables: {[string]:field<any>};
}

export type field<T> = {
    __type: "field";
    type: string;
    key: string;
    value: T?;
}

return nil