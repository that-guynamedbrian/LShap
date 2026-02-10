export type namespace = {
    name: string;
    classes: {[string]:class};
}

export type class = {
    hooks: {};
    mutables: {};
    immutables: {};
}