global class MetadataWrapper extends MetadataWrapperInterface{
    @InvocableVariable(label='First Name')
    global string first_name;
    global string getfirst_name(){return first_name;}
    global void setfirst_name(string first_name){
        this.first_name = first_name;
    }
    public static MetadataWrapper parse(String json) {
    return (MetadataWrapper) System.JSON.deserialize(json, MetadataWrapper.class);
}
}