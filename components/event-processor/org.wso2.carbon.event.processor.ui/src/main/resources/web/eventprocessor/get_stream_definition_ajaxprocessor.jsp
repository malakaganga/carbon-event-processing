<%--
  ~ Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>
<%@ page import="org.wso2.carbon.event.processor.ui.EventProcessorUIUtils" %>
<%@ page import="org.wso2.carbon.event.stream.stub.EventStreamAdminServiceStub" %>
<%@ page import="org.wso2.carbon.event.processor.ui.UIConstants" %>

<%
    EventStreamAdminServiceStub streamAdminServiceStub = EventProcessorUIUtils.getEventStreamAdminService(config, session, request);
    String strStreamId = request.getParameter("streamId");
    String strStreamAs = request.getParameter("streamAs");
    String strIsArbitrary = request.getParameter("isArbitrary");

    if (strStreamId != null) {
        String definition = streamAdminServiceStub.getStreamDefinitionAsString(strStreamId);

        if (strIsArbitrary != null && strIsArbitrary.equals(UIConstants.TRUE_LITERAL)) {
            definition = definition + UIConstants.ARBITRARY_DATA_OBJECT;
        }

        StringBuilder formattedDefinition = new StringBuilder("");
        StringBuilder unformattedDefinition = new StringBuilder("");
        String[] attributes = definition.trim().split(",");
        boolean appendComma = false;
        for (String attribute : attributes) {
            attribute = attribute.trim();
            if (attribute.length() > 0) {

                String[] nameType = attribute.split(" ");
                if (appendComma) {
                    formattedDefinition.append(", ");
                    unformattedDefinition.append(", ");
                }
                formattedDefinition.append("<b>");
                formattedDefinition.append(nameType[0].trim());
                formattedDefinition.append("</b>");
                formattedDefinition.append(" ");
                formattedDefinition.append(nameType[1].trim());

                unformattedDefinition.append(attribute);
                appendComma = true;
            }
        }

        String streamDefinitionString = strStreamId + " |= " + strStreamAs + " |= " + formattedDefinition + " |= " + unformattedDefinition;

%>

<%=streamDefinitionString%>
<%
    }

%>
