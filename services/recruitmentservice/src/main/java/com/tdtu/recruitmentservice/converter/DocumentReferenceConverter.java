package com.tdtu.recruitmentservice.converter;

import com.google.cloud.firestore.DocumentReference;
import com.tdtu.recruitmentservice.util.FirestoreUtil;
import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;

public class DocumentReferenceConverter implements Converter {

    @Override
    public boolean canConvert(Class clazz) {
        return DocumentReference.class.isAssignableFrom(clazz);
    }

    @Override
    public void marshal(Object value, HierarchicalStreamWriter writer, MarshallingContext context) {
        DocumentReference documentReference = (DocumentReference) value;
        writer.setValue(documentReference.getPath());
    }

    @Override
    public Object unmarshal(HierarchicalStreamReader reader, UnmarshallingContext context) {
        String path = reader.getValue();
        return FirestoreUtil.getDocumentReference(path);
    }
}
