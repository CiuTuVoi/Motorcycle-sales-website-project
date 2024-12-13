import { fetchUtils } from "react-admin";
import simpleRestProvider from "ra-data-simple-rest";

const apiUrl = "http://localhost:5000";

const httpClient = fetchUtils.fetchJson;

const dataProvider = simpleRestProvider(apiUrl, httpClient);

export default dataProvider;
