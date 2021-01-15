import React, {useCallback, useContext} from 'react'
import {useDropzone} from 'react-dropzone'
import axios from "axios"
import {AuthContext} from '../providers/AuthProvider'

function DropZoneDemo() {

  const {setUser} =useContext(AuthContext)

  const onDrop = useCallback((acceptedFiles) => {
    // Do something with the files
    console.log("acceptedFiles ",acceptedFiles)
    let data = new FormData()
    data.append('file', acceptedFiles[0])
    axios.put('/api/update_user_image', data)
    .then((res)=>{
      // debugger
      setUser(res.data.user)
    })
    .catch((err)=> {
      debugger
    })

  }, [])
  const {getRootProps, getInputProps, isDragActive} = useDropzone({onDrop})
 
  return (
    <div {...getRootProps()}>
      <input {...getInputProps()} />
      {
        isDragActive ?
          <p>Drop the files here ...</p> :
          <p>Drag 'n' drop some files here, or click to select files</p>
      }
    </div>
  )
}

export default DropZoneDemo