@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

echo In OpenVino Variables file
setx ROOT "C:\Program Files (x86)\IntelSWTools\openvino"
setx INTEL_OPENVINO_DIR "C:\Program Files (x86)\IntelSWTools\openvino"
setx INTEL_CVSDK_DIR "C:\Program Files (x86)\IntelSWTools\openvino"
setx OpenCV_DIR "C:\Program Files (x86)\IntelSWTools\openvino\opencv\cmake"
setx OPENVX_FOLDER "C:\Program Files (x86)\IntelSWTools\openvino\openvx	"

setx InferenceEngine_DIR "C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\inference_engine\share"
setx HDDL_INSTALL_DIR "C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\inference_engine\external\hddl"
setx ngraph_DIR "C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\ngraph\cmake"
setx PATH "%PATH%;C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\ngraph\lib;C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\inference_engine\external\tbb\bin;C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\inference_engine\bin\intel64\Release;C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\inference_engine\bin\intel64\Debug;C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\inference_engine\external\hddl\bin;C:\Program Files (x86)\IntelSWTools\openvino\deployment_tools\model_optimizer;C:\Program Files (x86)\IntelSWTools\openvino\opencv\bin;C:\Program Files (x86)\IntelSWTools\openvino\openvx\bin;"

echo Permanent Variable set
