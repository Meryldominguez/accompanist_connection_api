import * as React from "react";
import * as ReactDOM from "react-dom";
import {
    createBrowserRouter,
    RouterProvider,
  } from "react-router-dom";

  const router = createBrowserRouter([
    {
      path: "/",
      element: <div>Hello world!</div>,
      errorElement: <div>OH NO!</div>
    },
    // {
    //     path: "*",
    //     element: <div>OH NO!</div>
    // },
  ]);

ReactDOM.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>,
  document.getElementById('root')
);