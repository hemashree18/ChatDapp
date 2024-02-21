import "../styles/globals.css";

import { ChatAppProvider } from "@/Context/ChatAppContext";
import { NavBar } from "@/components/index";
const MyApp = ({Component , pageprops}) => (
    <div>
        <ChatAppProvider >
            <NavBar/>
        <Component {...pageprops}/>
        </ChatAppProvider>
    </div>
);

export default MyApp;